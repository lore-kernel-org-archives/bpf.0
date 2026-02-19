Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FE234984
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771463595; cv=none; b=l3tkCHdrNZ+vD9moE+bz1dKvThkuxoQlWMJ9vaPHt6BFwmzeQenXHDtmBurb52NsdNZxKBrmDJ2EpSCF+eggpTv5Eov1kg+3B62LiWGm6IqOb6wDt0HYqdVcJil41CaX5a0zkNbo+kd9U3jG4qFb85xE/dj46kBKRxQLL0xpCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771463595; c=relaxed/simple;
	bh=A+VT5+BsIR/a3Qzvhm7j+Pf2wFJv6fT9CMBrm9wXpYM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ybs6chnI+7Z6kf0pXHyiOHCWb1fH/VIzC1fhmhPxkQfG3myeQSUqV9ESGwsFDbkyLbau65qPT+m0epi92nke7tkV/t8U6zjOv4GwLzGJKbWrfIKMcmHm3du4MGSvbonFFPo1INSQ4gFVj0B1xJleU+5PuKNJZC6CrwORWVyvPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BvQgQcNM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BvQgQcNM"
Message-ID: <54cffd1f-df2f-4a01-a07d-0509425558d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771463590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPMTLBQvRNETuIrCkCAVjc0UXZ7p6OpQAPvFEm5Rxig=;
	b=BvQgQcNMUEnxnJB5aByo3kYo/UeIKNNSjc5/AjMk8uciZt1j7tuwRkAt4yOYw3PEe9QHzx
	iEZ/Nq9/YmMhTFhGzAya+Xo8mH/FlM4WAi8P1qvYQZr19JK6C6fHmPwB1xZtV4+9AqiaIl
	DS+0/GqnKVWhBfU9/o4/DVyYUt9mhMo=
Date: Wed, 18 Feb 2026 17:12:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 14/15] selftests/bpf: Check BPFTOOL env var in
 detect_bpftool_path()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
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
 <84ba9764-5ba2-4e9b-af81-3fea2682d161@linux.dev>
Content-Language: en-US
In-Reply-To: <84ba9764-5ba2-4e9b-af81-3fea2682d161@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/18/26 10:17 AM, Ihor Solodrai wrote:
> On 2/18/26 9:38 AM, Alexei Starovoitov wrote:
>> On Tue, Feb 17, 2026 at 4:31 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>
>>> [...]
>>>
>>>         /* Check default bpftool location (will work if we are running the
>>>          * default flavor of test_progs)
>>>          */
>>>         snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
>>>         if (access(tmp, X_OK) == 0) {
>>> -               strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
>>> +               snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
>>
>> I guess it's ok for user space, but
>>
>> git log --oneline|grep "snprintf with strscpy"
>> ad789a85b163 mm/cma: replace snprintf with strscpy in cma_new_area
>> 674fb053e95d sparc: vio: Replace snprintf with strscpy in vio_create_one
>> 2dfc417414c6 genirq/proc: Replace snprintf with strscpy in register_handler_proc
>> f46ebb910989 block: Replace snprintf with strscpy in check_partition
>> b66215e7b780 media: verisilicon: replace snprintf with strscpy+strlcat
>> a86028f8e3ee staging: most: sound: replace snprintf with strscpy
>>
>> and many others...
>> So.. should we introduce strscpy() in selftests/bpf ?
> 
> I guess we can, but:
> 
> $ grep -r 'snprintf(' --include="*.[ch]" tools/testing/selftests/bpf/ | wc -l
> 238
> 
> The reason to prefer strscpy() is speed, right?
> Can we use kernel implementation in userspace directly?
> 
> In tools/include I only see this:
> 
> 	#define strscpy strcpy
> 

I think we can add a simple implementation to tools/lib/string.c
See a diff below: essentially a copy from arch/s390/boot/string.c [1]

I suppose it's faster than snprintf(). However I am not sure about
going through all 238 usages, as that would touch many files. But at
least we can make actual strscpy available in selftests.

I can add this in v3. Alexei, wdyt?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/boot/string.c?h=v6.19#n32

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index 51ad3cf4fa82..ca183a0e846a 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_STRING_H_
 
 #include <linux/types.h>	/* for size_t */
+#include <sys/types.h>		/* for ssize_t */
 #include <string.h>
 
 void *memdup(const void *src, size_t len);
@@ -12,7 +13,7 @@ void argv_free(char **argv);
 
 int strtobool(const char *s, bool *res);
 
-#define strscpy strcpy
+ssize_t strscpy(char *dest, const char *src, size_t count);
 
 /*
  * glibc based builds needs the extern while uClibc doesn't.
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 3126d2cff716..54c9163fa2b0 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -239,3 +239,17 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 
 	return check_bytes8(start, value, bytes % 8);
 }
+
+ssize_t strscpy(char *dst, const char *src, size_t count)
+{
+	size_t len;
+
+	if (count == 0)
+		return -E2BIG;
+
+	len = strnlen(src, count - 1);
+	memcpy(dst, src, len);
+	dst[len] = '\0';
+
+	return src[len] ? -E2BIG : len;
+}


