Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ECB35A3B6
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350120; cv=none; b=Qv8i5xU+9T3FMonD35iYRcS+6d8NQvNuamarkUCmkZ/K0977Q3UxwS/e1rbA7EXXGR4YETyKPSLFAP23NKeCCNGmr++fxe3IWhgkFrKlZPdQppMdWIaf/1ulagCO1LqEyVzPmB+3ExT6ytc5bGLW7EZAvqQuIOOPK9XJf6+fXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350120; c=relaxed/simple;
	bh=z2HKshWhyIhbw3maJi1KWoYfb1ShZsVIostZxGXsMVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbaWzOyebY7NjvHlVSUgEC6PvSbJ7znjh5xc1iSPOtA2hx4Ag699tWG+GMtermy875SQf9wEZLpL3u4noNrltr2uxjFxToxQH+dlm8r6FJC638Wz8c/wQajEmn4oSDP4Of3K2IMOFnOsnflUflpHe3iTB955uELpgLrdez30OXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Em8IrcE3; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Em8IrcE3"
Message-ID: <7468775e-8cfe-49e2-8271-2263c85f416a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773350113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcwTwI+oYmnBqCEvyYdSK17h3VM9k606dNGZTDFZDsE=;
	b=Em8IrcE3OwZJRDf7Od3xyO7HP4tjTKUkr4b+dhsEqGaZXT8BPtD4GUii97gwDzWigp31es
	oztI1KJlz5+WBYl3hnRgkZTi5jS939gL6gyKO6te5/NFmG1AmTa6XSunsCQQ9enBd0DSdh
	M+PX0ohuvP1mBYreLLTr4+/ELjV2dCQ=
Date: Thu, 12 Mar 2026 14:14:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] selftests/bpf: Bump path and command buffer sizes
 in bpftool_helpers.c
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260312195017.210430-1-ihor.solodrai@linux.dev>
 <CAEf4Bza-cEaCg1s9pppdRAS1idx71wjZ4+7g-gkM_JXzD1xSyg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bza-cEaCg1s9pppdRAS1idx71wjZ4+7g-gkM_JXzD1xSyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/12/26 1:40 PM, Andrii Nakryiko wrote:
> On Thu, Mar 12, 2026 at 12:50 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> The path length of 64 is way too low in some envirnoments, which leads
>> to subtle failures due to truncation [1].
>>
>> Replace BPFTOOL_PATH_MAX_LEN with PATH_MAX, and set
>> BPFTOOL_FULL_CMD_MAX_LEN to double of PATH_MAX.
>>
>> [1] https://github.com/libbpf/libbpf/actions/runs/22980753016/job/66719800527
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/testing/selftests/bpf/bpftool_helpers.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
>> index 929fc257f431..6a5e99b5e542 100644
>> --- a/tools/testing/selftests/bpf/bpftool_helpers.c
>> +++ b/tools/testing/selftests/bpf/bpftool_helpers.c
>> @@ -2,18 +2,18 @@
>>  #include <unistd.h>
>>  #include <string.h>
>>  #include <stdbool.h>
>> +#include <limits.h>
>>
>>  #include "bpf_util.h"
>>  #include "bpftool_helpers.h"
>>
>> -#define BPFTOOL_PATH_MAX_LEN           64
>> -#define BPFTOOL_FULL_CMD_MAX_LEN       512
>> +#define BPFTOOL_FULL_CMD_MAX_LEN       (PATH_MAX * 2)
>>
>>  #define BPFTOOL_DEFAULT_PATH           "tools/sbin/bpftool"
>>
>>  static int detect_bpftool_path(char *buffer, size_t size)
>>  {
>> -       char tmp[BPFTOOL_PATH_MAX_LEN];
>> +       char tmp[PATH_MAX];
>>         const char *env_path;
>>
>>         /* First, check if BPFTOOL environment variable is set */
>> @@ -29,7 +29,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
>>         /* Check default bpftool location (will work if we are running the
>>          * default flavor of test_progs)
>>          */
>> -       snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
>> +       snprintf(tmp, PATH_MAX, "./%s", BPFTOOL_DEFAULT_PATH);
> 
> nit, but why not s/PATH_MAX/sizeof(tmp)/?

Hi Andrii, thanks for quick review.

I just did the s/BPFTOOL_PATH_MAX_LEN/PATH_MAX in v1, will fix up.

> 
>>         if (access(tmp, X_OK) == 0) {
>>                 strscpy(buffer, tmp, size);
>>                 return 0;
>> @@ -38,7 +38,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
>>         /* Check alternate bpftool location (will work if we are running a
>>          * specific flavor of test_progs, e.g. cpuv4 or no_alu32)
>>          */
>> -       snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
>> +       snprintf(tmp, PATH_MAX, "../%s", BPFTOOL_DEFAULT_PATH);
>>         if (access(tmp, X_OK) == 0) {
>>                 strscpy(buffer, tmp, size);
>>                 return 0;
>> @@ -50,7 +50,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
>>
>>  static int run_command(char *args, char *output_buf, size_t output_max_len)
>>  {
>> -       static char bpftool_path[BPFTOOL_PATH_MAX_LEN] = {0};
>> +       static char bpftool_path[PATH_MAX] = {0};
> 
> this doesn't matter in practical terms, but I'm not sure all people
> realize that this initializes entire buffer with zeroes, not just
> first byte. `= {0}` is super misleading, it's better to use `= {}` in
> cases like this

I think setting the entire buffer to 0 to determine if the path is
cached is an overkill, although in this particular case it's not
important since the buffer is static.

I'll change to {}, I agree it's more obvious.

Not directly relevant, but fun news re {0} init, courtesy of Eduard:
https://news.ycombinator.com/item?id=43792948


> 
>>         bool suppress_output = !(output_buf && output_max_len);
>>         char command[BPFTOOL_FULL_CMD_MAX_LEN];
>>         FILE *f;
>> @@ -84,4 +84,3 @@ int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_l
>>  {
>>         return run_command(args, output_buf, output_max_len);
>>  }
>> -
>> --
>> 2.53.0
>>

