Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768841A9F97
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889364; cv=none; b=cB87iMlz0IOpqmYJc07hRWQyg9YfLVF3a3vlDnnkfhIFd2iHxjUUlTpsQv5p4t5FE5b1cASHtJjjWpV7ImfRsMIF/SEVe0rHR5CmXcX9TU3YWISBcCclcSmZ0GaItCqsC8XFaDjyOOH1YmKVZSv6fvwM08nfPyOkVVMwdke/NqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889364; c=relaxed/simple;
	bh=mYmmAQSde6F7Y/E1QWGy1zeR+da/doe1A8t8muctFB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2lC2xelP0iNIGP3u5AzP+n4Sng042/2ZLkj7khoY2UOMjsIB+jfEEIPH5YHYnRIxA7xGo8MbIjHGVKTQVU69kkyZtaSxH0nO3Bde3uEXlSa6cjvfdYwcuO9Py0YpEdu8qJ6sg5/co1lmE40XNk4j5FnhE4EHskeJ6Ia7MwPZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHa7k8Kk; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHa7k8Kk"
Message-ID: <bfb432db-bd29-419a-8147-78ff6fac07ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782889360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YHZ7VeExib9bwMl0hMRMS3DxaFLnavLkPtqkc6DdGk=;
	b=hHa7k8KkncHcXNYwNh7nMxCdcxfZ3P0OQrLgq3ymz66x4F86OrXag/T4CKo4bm7Cn/Y1ZT
	GxRfGYCmBG2UjR3EQ9Cb+1c6+2LNvIRjRuSfN/CmOG5XuHYrhodAMK/ZeqMda2RbaJ6iOM
	h9DOhM8MMN6SkXZny8bnhF5ALXkBcAU=
Date: Wed, 1 Jul 2026 15:02:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user
 BPF_ADDR_SPACE_CAST insn
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, KaFai Wan <kafai.wan@linux.dev>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <20260626154330.33619-2-leon.hwang@linux.dev>
 <e279c9a7ca6b16e52dc261560513b0eafdd70f87.camel@linux.dev>
 <a2aaa21d-4cf9-48a4-839f-dd152bda8185@linux.dev>
 <af9c0a7e-13de-c227-849f-4b35d1fb74ff@loongson.cn>
 <d55e10b1-d883-4fcf-8fb3-8210db935e4a@linux.dev>
 <1c07a34f-b050-a281-6a7b-542a9bfa30b3@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <1c07a34f-b050-a281-6a7b-542a9bfa30b3@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/7/26 14:49, Tiezhu Yang wrote:
[...]
>>
>> It is a real issue.
>>
>> Instead of fixing up helper calls, it seems better to prevent
>> interpreter fallback if the prog has any JIT-inlineable helper call.
> 
> Hi Alexei and Leon,
> 
> What about the following: (not tested yet, if it is good, I can test it)
> 
> [...]
> 
> If you are OK with the above changes, I will test it again and send
> a new version later.
> 

If you don't mind, I think I can disallow the interpreter fallback by
the below diff in the next revision of this series.

The 'aux->jit_required' is introduced by following Alexei's suggestion.

Thanks,
Leon

---

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index b5a273a5f944..677b6d2a6ba4 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1841,8 +1841,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
                }

                /* Skip inlining the helper call if the JIT does it. */
-               if (bpf_jit_inlines_helper_call(insn->imm))
+               if (bpf_jit_inlines_helper_call(insn->imm)) {
+                       prog->aux->jit_required = true;
                        goto next_insn;
+               }

                if (insn->imm == BPF_FUNC_get_route_realm)
                        prog->dst_needed = 1;
