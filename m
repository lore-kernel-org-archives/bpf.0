Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0F373C0C
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773593103; cv=none; b=HNzXiHbLrjmntnB3TkBpvzPQUEanqwGqwuKbWVsyWvyvFDAAHliuz74LpSRRHI8KS3YtVRw8FekVNFF0KxYihRnR3swKrmor00HBoDdEhHZ6GmvqrGyfOyyDO07C0qhY9JTsROE949NFyoRVJK60DCS2QWMs27PhhUKVNz+OclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773593103; c=relaxed/simple;
	bh=EaUAwKfk1pYCiPnR95+voQwIKZP/WHGMOY8kPjCJGQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD9V/Rn2dOtisfQs4SLfqYoHtae4U8fvfDqL9Vw9+8RFDjh16DJVCugPLn6/HQaSSIR6xp9OXLmemDXSF0EcrUh+ztQE/gvDIxPjkHzL0AtLZy8zCLPZafCI1ygAvXhUYcTXG9l2Mqs9Y065J2E4rGl0jCLSRDyiW3S77EMoKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IYaFTzyQ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IYaFTzyQ"
Message-ID: <6555dc32-b651-4c45-adaf-e3aecb013904@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773593100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfVgWC/kUc0Eksi2IfYDFwks3YrVHqxzEhca1Pyur7g=;
	b=IYaFTzyQtoHqS74uWZY/TQAeJinECnpokR5dvOinjxOCHCiRxNZlyYeg/CSSA1eeTS4+fl
	WgmWQwjVZZQDHRSAYEFVr03UQJrBpnQN1YnE5Hm7AQgUA/7f+3hullFiXkp5q98BiE1uWV
	L4i34PgWPDj6QCqYpw0EWLQBi56Ht6A=
Date: Sun, 15 Mar 2026 09:44:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Improve connect_force_port
 test reliability
Content-Language: en-GB
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260312062042.387367-1-jiayuan.chen@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260312062042.387367-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/11/26 11:20 PM, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> No functional changes.

This is not true as you mentioned below.

>
> The connect_force_port test can fail intermittently because the
> hardcoded server ports (60123/60124) may already be in use by other
> tests or processes in CI environments [1].
>
> Fix this by using dynamically assigned ports (port 0) for start_server
> and propagating the actual port to the BPF programs at runtime via
> skel->bss->port. Convert the test from the legacy bpf_object__open_file
> loading model to the skeleton (skel) pattern, which provides direct
> access to BPF global variables without introducing maps or other
> mechanisms.

I suggest you have two patches:
   . patch 1: fix port issue
   . patch 2: improve code from bpf_object__*() to skel based.
     patch 2 is optional.

>
> Test:
>
>    ./test_progs -a connect_force_port -v
>
>    test_v4:PASS:skel4_open_and_load 0 nsec
>    attach_progs:PASS:attach connect 0 nsec
>    attach_progs:PASS:attach getpeername 0 nsec
>    attach_progs:PASS:attach getsockname 0 nsec
>    run_tests:PASS:start_server tcp 0 nsec
>    run_tests:PASS:get_socket_local_port 0 nsec
>    run_tests:PASS:connect_to_fd 0 nsec
>    run_tests:PASS:verify_ports 0 nsec
>    run_tests:PASS:start_server udp 0 nsec
>    run_tests:PASS:get_socket_local_port 0 nsec
>    run_tests:PASS:connect_to_fd 0 nsec
>    run_tests:PASS:verify_ports 0 nsec
>    test_v6:PASS:skel6_open_and_load 0 nsec
>    attach_progs:PASS:attach connect 0 nsec
>    attach_progs:PASS:attach getpeername 0 nsec
>    attach_progs:PASS:attach getsockname 0 nsec
>    run_tests:PASS:start_server tcp 0 nsec
>    run_tests:PASS:get_socket_local_port 0 nsec
>    run_tests:PASS:connect_to_fd 0 nsec
>    run_tests:PASS:verify_ports 0 nsec
>    run_tests:PASS:start_server udp 0 nsec
>    run_tests:PASS:get_socket_local_port 0 nsec
>    run_tests:PASS:connect_to_fd 0 nsec
>    run_tests:PASS:verify_ports 0 nsec
>    #80      connect_force_port:OK
>    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> [1] https://github.com/kernel-patches/bpf/actions/runs/22697676317/job/65808536038
>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>   .../bpf/prog_tests/connect_force_port.c       | 190 +++++++++---------
>   .../selftests/bpf/progs/connect_force_port4.c |  10 +-
>   .../selftests/bpf/progs/connect_force_port6.c |  10 +-
>   3 files changed, 108 insertions(+), 102 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
> index 24d553109f8dd..3e62f9b9f1d94 100644
> --- a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
> +++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
> @@ -3,6 +3,8 @@
>   #include <test_progs.h>
>   #include "cgroup_helpers.h"
>   #include "network_helpers.h"
> +#include "connect_force_port4.skel.h"
> +#include "connect_force_port6.skel.h"
>   
>   static int verify_ports(int family, int fd,
>   			__u16 expected_local, __u16 expected_peer)
> @@ -46,122 +48,122 @@ static int verify_ports(int family, int fd,
>   	return 0;
>   }
>   
>
[...]

