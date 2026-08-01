Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3638DC46
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609291; cv=none; b=X3amqJxUGrVjoo9YZ9gbbv9a2e/NiL2KuDkRQ9KEbBjcRyvhqZ7q1Xs59tdeEfuTtApK168QmmImwBj9euuOSqYFDStdcEbynHYc/WkAG5xNHgv25QQPassgbgG5vCxsTcC8mxJHOCiFtyuddskP1P3mcocX0GlkkQLgwyOe1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609291; c=relaxed/simple;
	bh=RPPeB+uzBNWIy1SVKz3NsXb93pretH2jSyOBaj/hQGU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a1Cju1UeuZnrK9vypHfZSSGycolvWecVSlJggxrIiOIgK4kUsgejti+nMHn5tewqVzLC5/ZrRWn6GpCZ0p3h8f2JPPxe68MKJK7gj6BcoGqZFMChTAY2N0+t1CJeLzHQhT9QAuFyKgM8q21p8AcGmeSLGLUAbVGrDvmYTp7xma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rizhOUE1; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rizhOUE1"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so1037029f8f.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785609287; x=1786214087; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nSvM9cc6VvavWB+KiyrrP05uMve1IQtkth4wsZ7Q1Yw=;
        b=rizhOUE1JA7UBgEg0v1s1zLQcd8jq+ynHkT8z3+88JcyRxEn1Xvf8gEtU46VwPQcp3
         +Q77VEWhQ861IOMsYp+dwnVt0jVHoYW3yhAS1wzxYiv4fGGbtupn4sM4vvYk9sUH4X6N
         YVleWi4ta3ZmrmpR951nOdpenJVt9pcJduFAr7VC2nf+WO0hG3jPfmOHVRqiMsJgdzmO
         JxipRg73aMdVyk91dV8s83wTMPSuDKwx+vQOvN5NH3MG395X/oeSX1uieQnj+HLbcn0W
         5VPe9xyuo/cHjp+S4pOiyyTwPaXBJbvOMAy9tdRixrIPmuEg+Esv3NWkRGM3Ntbpl9Mt
         YSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785609287; x=1786214087;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSvM9cc6VvavWB+KiyrrP05uMve1IQtkth4wsZ7Q1Yw=;
        b=RMEwJIl10G6Y5XIGQ/0AZmEeoK4BI9hCFC2B4mmq7ijctX9dn2vbvXZt/1tAsKOONa
         9J6hoTnXaYgMjR4TascpNQ5/U4iDEaYbJMFf862bDcBAVqutpavWuuz9epYfJtudozmZ
         c/ePmTPwI/kZ7hP+l+JtsFPJ0G7vDgwNZTfpyEw3/OsvZKxy6AIiw1DAOpC4BIHx9ruG
         N7KA2C8m/cp3HRUoLK8lKoXEoHC1EumUg8z76ZOFfgh2YEJzP2k8ZWfprUsNEDuekcf8
         DUnBNZiJ6XFvTiTU1/xFVv9AjrcdRsjQM4yoEgkG5FA/8RS2OrrDfl2E1ESc+OyqKUD4
         DnnA==
X-Forwarded-Encrypted: i=1; AHgh+RrNRrXmmiej3LBIlglEXngbJGynw4ZRiIC85sEUbHJnuiXSXLTiPkxKTGT0UXb1VW3FGiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZjCOY2Q8ylLHjIIYqZNjmaFdnb8NVTG9lgMoXoey3jepMp2v
	ubh1DaMhDY337vGwsBgRe1HpwRxV5+ChOMDe+F+GZEUdtFvjCCLBW8ZN
X-Gm-Gg: AR+sD11euoNLyujj6jmXK6TsPoQs5lmBDsJkLsvUf3D/e+oONxaDF0D/NBqzYsqZnD+
	asdWBMfINygiRya0CU/KUl6g8Mnww9a1QFHHOXf8TMBGv5QtA/XKbkUqiKMcgvGuTSknAmfMiho
	x5GQHfuImIoupSt4rPtIlVhwFLmK1PQSEN6gZpLjI7G14B4KHkJpetZhP8j9xQ/SNmGCjBzbtVg
	Jv+tuhz006TywXqqCCU9+SAJtpBr7ckoMbvn9qHKnFjHNqtzL1GrxA1SWQph7htJy9ykNkjckcZ
	d7jg3VBj8VBsffUMGyOcS0c5M2utSYO9P9IfnGtcJPZR6elrWmxGSC2wic4E+ffqJijMKgLfcHj
	SQGN97ol9/LT3cAer8gvB/2A9SgLtyrtbwX6se5OB+MhLHTzlEXQhqpYcr5ahNuW4YWaIpKKufn
	2lKUXYJfvBR7yPpfPr7yShIhNpWX8NV9lAj9IM5ITCIa9oiZ6WzgyZRFZ+smk/nWGWQI/Ip13pw
	Z2Db/DQNrTWmGMMRvNynZj/ZUnGjEA4OXlEiAzghc/WFw5l9uJByVDSrA2eRf9WvwhVcM2XhlvN
	bJqdr0UEJJVs6sIdQRA574W429Q=
X-Received: by 2002:a05:6000:41c5:b0:47f:6f9e:1e82 with SMTP id ffacd0b85a97d-47fd72bbc06mr10922416f8f.9.1785609286811;
        Sat, 01 Aug 2026 11:34:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bb4esm17263531f8f.30.2026.08.01.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 11:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 20:34:45 +0200
Message-Id: <DKDTNXL3VX2R.1WMB80L6BH6RS@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Mykyta Yatsenko" <yatsenko@meta.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Russell King"
 <linux@armlinux.org.uk>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add __bpfcall attribute to
 bpf_task_work_callback()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Heiko Carstens" <hca@linux.ibm.com>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260727093834.2178900-1-hca@linux.ibm.com>
 <c1b15a2a-88d2-4f30-a827-9a96bc35b365@gmail.com>
 <20260727141302.11274B21-hca@linux.ibm.com>
In-Reply-To: <20260727141302.11274B21-hca@linux.ibm.com>

On Mon Jul 27, 2026 at 4:13 PM CEST, Heiko Carstens wrote:
> On Mon, Jul 27, 2026 at 02:09:12PM +0100, Mykyta Yatsenko wrote:
>> On 7/27/26 10:38 AM, Heiko Carstens wrote:
>> > BPF kCFI support is optional for architectures which support kCFI.
>> > If an architecture provides bpf kCFI support it must override the
>> > default __bpfcall define (which translates to __nocfi).
>> >
>> > Add the missing __bpfcall attribute to bpf_task_work_callback() which
>> > calls bpf programs indirectly to avoid CFI checks for such cases.
>> >
>> > Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
>> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>> > ---
>> >  kernel/bpf/helpers.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> > index 88b38db47de9..9bf82c9ea1da 100644
>> > --- a/kernel/bpf/helpers.c
>> > +++ b/kernel/bpf/helpers.c
>> > @@ -4447,7 +4447,7 @@ static void bpf_task_work_cancel(struct bpf_task=
_work_ctx *ctx)
>> >  		bpf_task_work_ctx_put(ctx);
>> >  }
>> >
>> > -static void bpf_task_work_callback(struct callback_head *cb)
>> > +static __bpfcall void bpf_task_work_callback(struct callback_head *cb=
)
>>
>> Thanks for the patch, I've already sent another fix:
>> https://lore.kernel.org/all/20260724-task_work_cfi-v1-1-2616691781ed@met=
a.com/
>> Is __bpfcall still needed?
>
> Yes, it is needed for architectures which select ARCH_SUPPORTS_CFI, and w=
hich
> in addition support bpf, but do not provide CFI support for bpf programs.
>
> As of now it looks like this is only the case for arm, at least as far as=
 I
> understand the code. It might be easier to implement bpf/cfi support for =
arm,
> then drop the __bpfcall macro entirely, and require from future architect=
ures
> to provde bpf/cfi support whenever they select ARCH_SUPPORTS_CFI.
>
> I'm writing the above, since due to AI feedback to this patch, there seem=
 to
> be more bpf functions which call bpf programs indirectly and which miss t=
he
> __bpfcall attribute.

I think letting arm JIT folks figure out CFI support is a better path.

pw-bot: cr
