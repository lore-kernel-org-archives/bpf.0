Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC52FFDDE
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438675; cv=none; b=XEPTTo4YMMlqrRYZaWiEQpAkOfM4F7M0NFQChf+bJbP3NyUmtwZfWbOdTv35dF4RK3lhI7+PWn2R+xfKWdeDHvU1fwoZ6kfg+FQGzIhRuGSXlGyvOVj2oBBNqATiRxA1jZ1ZlCxD/rdphhiFKRTYjtYWjHxNXbB7Werc/X/8KDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438675; c=relaxed/simple;
	bh=nkAa7104CS/g5Ysww/SUgB2Uh4odegF+jRsBlBm2qWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fElmt1Tm+KUW6bFE84BEih75UoQR7vNycgkuBXDkkedhoBMGJRH7poJc8DzP6nabZOJJnG8qalt2eIoBAD14ghYTIYSpCZIUvNqhdGE80fzfzpHDVmawMjmtqP9cXCKHsNhARM/BhPuLXFX/dPQfMy33dgtX119q5Sy9eaJv964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JtxeA4nj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JtxeA4nj"
Message-ID: <84ba9764-5ba2-4e9b-af81-3fea2682d161@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771438671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jLFosI0T6QYSkiSnkGchFuAZMTezEKCRfgE4hSITCU=;
	b=JtxeA4njFN8pbuzfRnc8q+dt+Te6z5W0OplAuiV8cqZD5lmFJpP9PLWBOMrmjLOv+gIZVW
	7lmrYhui+HTScKdp9/AmXU5wGDIsLhit5Pgtfs0wuzwSXU1w3nLvhPkXuK+Shn1w+71SOu
	ENT2nr2sb99xgcbn4ZkYwRPodCWpMds=
Date: Wed, 18 Feb 2026 10:17:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 14/15] selftests/bpf: Check BPFTOOL env var in
 detect_bpftool_path()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
 <20260218003041.1156774-15-ihor.solodrai@linux.dev>
 <CAADnVQLOONuA3omz1ZRoT5T39PpYfut3vXnH1Oxdh84pJA6c-Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQLOONuA3omz1ZRoT5T39PpYfut3vXnH1Oxdh84pJA6c-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/18/26 9:38 AM, Alexei Starovoitov wrote:
> On Tue, Feb 17, 2026 at 4:31 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> The bpftool_maps_access and bpftool_metadata tests may fail on BPF CI
>> with "command not found", depending on a workflow.
>> This happens because detect_bpftool_path() only checks two hardcoded
>> relative paths:
>>   - ./tools/sbin/bpftool
>>   - ../tools/sbin/bpftool
>>
>> Add support for a BPFTOOL environment variable that allows specifying
>> the exact path to the bpftool binary.
>>
>> Also replace strncpy() with snprintf() for proper null-termination.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/testing/selftests/bpf/bpftool_helpers.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
>> index a5824945a4a5..d810e73da6c8 100644
>> --- a/tools/testing/selftests/bpf/bpftool_helpers.c
>> +++ b/tools/testing/selftests/bpf/bpftool_helpers.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  #include "bpftool_helpers.h"
>> +#include <stdio.h>
>>  #include <unistd.h>
>>  #include <string.h>
>>  #include <stdbool.h>
>> @@ -12,13 +13,24 @@
>>  static int detect_bpftool_path(char *buffer)
>>  {
>>         char tmp[BPFTOOL_PATH_MAX_LEN];
>> +       const char *env_path;
>> +
>> +       /* First, check if BPFTOOL environment variable is set */
>> +       env_path = getenv("BPFTOOL");
>> +       if (env_path && access(env_path, X_OK) == 0) {
>> +               snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", env_path);
>> +               return 0;
>> +       } else if (env_path) {
>> +               fprintf(stderr, "bpftool '%s' doesn't exist or is not executable\n", env_path);
>> +               return 1;
>> +       }
>>
>>         /* Check default bpftool location (will work if we are running the
>>          * default flavor of test_progs)
>>          */
>>         snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
>>         if (access(tmp, X_OK) == 0) {
>> -               strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
>> +               snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
> 
> I guess it's ok for user space, but
> 
> git log --oneline|grep "snprintf with strscpy"
> ad789a85b163 mm/cma: replace snprintf with strscpy in cma_new_area
> 674fb053e95d sparc: vio: Replace snprintf with strscpy in vio_create_one
> 2dfc417414c6 genirq/proc: Replace snprintf with strscpy in register_handler_proc
> f46ebb910989 block: Replace snprintf with strscpy in check_partition
> b66215e7b780 media: verisilicon: replace snprintf with strscpy+strlcat
> a86028f8e3ee staging: most: sound: replace snprintf with strscpy
> 
> and many others...
> So.. should we introduce strscpy() in selftests/bpf ?

I guess we can, but:

$ grep -r 'snprintf(' --include="*.[ch]" tools/testing/selftests/bpf/ | wc -l
238

The reason to prefer strscpy() is speed, right?
Can we use kernel implementation in userspace directly?

In tools/include I only see this:

	#define strscpy strcpy

