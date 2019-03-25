Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF132C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 11:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4B420850
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 11:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfCYLzX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:55:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:44040 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbfCYLzX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 07:55:23 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8OCG-0003NH-3w; Mon, 25 Mar 2019 12:55:20 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8OCF-000FOj-SM; Mon, 25 Mar 2019 12:55:19 +0100
Subject: Re: [PATCH bpf-next] selftests: bpf: don't depend on hardcoded perf
 sample_freq
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190319215324.37242-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e880b488-1afb-d15e-29e2-df7940dc8def@iogearbox.net>
Date:   Mon, 25 Mar 2019 12:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190319215324.37242-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/19/2019 10:53 PM, Stanislav Fomichev wrote:
> When running stacktrace_build_id_nmi, try to query
> kernel.perf_event_max_sample_rate sysctl and use it as a sample_freq.
> If there was an error reading sysctl, fallback to 5000.
> 
> kernel.perf_event_max_sample_rate sysctl can drift and/or can be
> adjusted by the perf tool, so assuming a fixed number might be
> problematic on a long running machine.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Mostly trying to understand rationale a bit better in context of
selftests; perf_event_max_sample_rate could drift also after this
patch here, but I presume you are saying that the frequency we
request below would interfere too much with perf tool adjusted
one and thus affect whole rest of kernel also after selftests
finished running, so below would handle it more gracefully, right?

> ---
>  .../bpf/prog_tests/stacktrace_build_id_nmi.c     | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> index 8a114bb1c379..1c1a2f75f3d8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> @@ -1,13 +1,25 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
>  
> +static __u64 read_perf_max_sample_freq(void)
> +{
> +	__u64 sample_freq = 5000; /* fallback to 5000 on error */
> +	FILE *f;
> +
> +	f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
> +	if (f == NULL)
> +		return sample_freq;
> +	fscanf(f, "%llu", &sample_freq);
> +	fclose(f);
> +	return sample_freq;
> +}
> +
>  void test_stacktrace_build_id_nmi(void)
>  {
>  	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
>  	const char *file = "./test_stacktrace_build_id.o";
>  	int err, pmu_fd, prog_fd;
>  	struct perf_event_attr attr = {
> -		.sample_freq = 5000,
>  		.freq = 1,
>  		.type = PERF_TYPE_HARDWARE,
>  		.config = PERF_COUNT_HW_CPU_CYCLES,
> @@ -20,6 +32,8 @@ void test_stacktrace_build_id_nmi(void)
>  	int build_id_matches = 0;
>  	int retry = 1;
>  
> +	attr.sample_freq = read_perf_max_sample_freq();
> +
>  retry:
>  	err = bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd);
>  	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
> 

