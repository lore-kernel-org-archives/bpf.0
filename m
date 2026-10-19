Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF349892C
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400718; cv=none; b=EKfRWVI4ivpyC3XDa+ctjM18enV8WzSjikQJBQEhodjiyBfesz+CggrvF5GN3PNIuCdF32E5HT0mKKl6LHlQcVYO7FzzGnYWmduX2o/i+l3Lg3J58m8y+WcHq1WxarZ7OFckJ11pzFMS+zuriDxlj/R5PDI5z+Qu5tFQZaZtQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400718; c=relaxed/simple;
	bh=gmnf5efQ2mINrLxGQXSf6UEgcGI1XJTCl1/2d7HLilM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWL+59vm5rX8Bf/A+Igsq/SK5UvDflbg7oumVPxicL6SntMTr3qPGM/Q5ANCDzcDJ4nMBhiuuYDhWRNvqA7ioM0cMhhEF6CHHc33Na7Hq8hYuWYUMqviavx7TIznJCD2+EWXnj/sFWWOk3RsYjQL6R2wRHVbPiAxknIS6sqYePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftwC1tnE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nKuifPyC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftwC1tnE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nKuifPyC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792400716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9io6NcVa485axIU0tMIo8oUR5zvQmfTZbiDmw/REe/0=;
	b=ftwC1tnEmaTflvLhcBBuQ/dB83a9H4exv9xxtyi/dCWCLHjpk0IUL46CsqXQpsJriFLnZr
	AEvxr60UYqEDp47Hy5cd9kMkOAPN/CLiuMWUEERboM0HM8JTMXMTyw3PhSbfIg05JhV6nt
	6kS4YYSPL2QROzAwm/hLkKf1gWgdkyQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-n8cNFc1TMx6Hc1Hb4i7NfQ-1; Mon, 19 Oct 2026 09:05:15 +0000
X-MC-Unique: n8cNFc1TMx6Hc1Hb4i7NfQ-1
X-Mimecast-MFC-AGG-ID: n8cNFc1TMx6Hc1Hb4i7NfQ_1792400714
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df02b91f9so1771685f8f.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792400714; x=1793005514; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9io6NcVa485axIU0tMIo8oUR5zvQmfTZbiDmw/REe/0=;
        b=nKuifPyCwRR760ffFYIZmOet8G7WIOqxHEt+kSQgvTbPxTIO3ATUof7g94lFOY3Yis
         wmmGdWtqEyASdacHCP96OKcDoZqcs7M7EJiPNRFSvuhzD3Rvu3EKl4Pkx47UMb0CwY55
         rP55r/kbAz5djlujD2igUxINJ5h4bSXzYTa2JhGPD41wO7QH4IfucIeHeqWdwwasAeCS
         3cvci2tSJne+lYMhqeRbjIDy4H0hW2Hq3hdr3V1U4DwlzJo43bz5FZu9zxRR8RGsYUZs
         MjTMFTjPBPnR3BODMFkwMMOXuNSvXCjNDevsOcSu0N2OHPLvui7LYAI3OEVACXYSE8RK
         6luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400714; x=1793005514;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9io6NcVa485axIU0tMIo8oUR5zvQmfTZbiDmw/REe/0=;
        b=BYR9HMf+NgKUOyg8ZqyeERvDfuhRB2KzGoSZ/+NDFr2RLr4heRv5oPBS7kGZ6Mdhb5
         9FeRz1IemBjazNzVtMrt870XKL9v/ZJyz/50Pjwqsz8T5GSntdkVvmSpwphXucDFuE+i
         vtz72U/ddYsVA26H7Eqx6GLOMTTfslMLhBIxxoYVYFa/qjfO5NXyYa9VmeZuu6Y0d+lJ
         mN2NruyQRrhcAT1V4/+JCo5yYM3a9yioAxgUQYtcUwK1FmIvTdaNo+Oqkb8lGoYANFu/
         VY7JdaEmjjLAUU2rhCILbfxTfgh61G1oPIBkwJcoOIaEKHfPzLMZG9eKmBEp9Hpv87kP
         0XFA==
X-Forwarded-Encrypted: i=1; AKwUvBwhqAi1w4xRAP7YOGZRbI3niSph89i2fc1H6CiyEYn6FcUECghPvd0PO6jtg4ui3MWEf6w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCizWBv/xkKZJCmDMKIeqMXxYim6AiszYhLtSFSqEJaIXA4ms7
	nfsNyH1rQlzTB1/t5p2hwqX/0JWq5M88agMSHqlcNkJaNDL3CtShrletoJ/j2pjvxw0obnaWv7A
	zL2m9YHNi3xOp24mixBkX0eWk/3yW0+Bz34P7ZJbxkT/g2CkeSLv42Q==
X-Gm-Gg: AYBFou3tOKS7P5tqTn9iguY0f0OnH847g5lHipkXvjtgE8Hj4WNDDDxXeycmK//MBjZ
	Zx3TocUlntEar1bLRkMZjywulfDZiYG/Lt70UXYVXJinR2ePNcs0uwi8eQ9n/oTwS4czcTExCgA
	NxvFsGp5Xnty2ddG+u7VoA5fRPyAO15fzhbCFgssmConKjZH4OTwrnXq8EdHm3aD8RGTEcvNS0O
	P0PV1jalyOGzIhHfsZSLToam+LKiHLZWziod/niwj7Q6o6PA6lNuFFdhd8wW9581gvej2lH/8e+
	cwu9/TUKhgn+T9oXgGu8TgEvIoY0X3wgoshG8r1ncucGcF3S2KsTqxjmsB5CkOuY9F3bn4OJmMe
	75X4CzTvIlTaRN3+VJhbQvlY7ug==
X-Received: by 2002:adf:ec91:0:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48dfae65b2dmr19629108f8f.13.1792400713426;
        Mon, 19 Oct 2026 02:05:13 -0700 (PDT)
X-Received: by 2002:adf:ec91:0:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48dfae65b2dmr19629060f8f.13.1792400712928;
        Mon, 19 Oct 2026 02:05:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f576asm23527360f8f.32.2026.10.19.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:05:12 -0700 (PDT)
Message-ID: <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Mon, 19 Oct 2026 11:05:10 +0200
In-Reply-To: <87ik2zryzo.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	 <87v770uuyr.fsf@jogness.linutronix.de>
	 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	 <87ik2zryzo.fsf@jogness.linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-10-18 at 14:16 +0206, John Ogness wrote:
> My issue with the /dev/kmsg design is bogus timestamps. But let's just
> drop my suggestion to allow eBPF programs to call printk(). Since the RV
> move to eBPF will require new user workflows anyway, the users will need
> to learn these new packages, tools, and output sources. The important
> thing (for me) is RV violations can still be used effectively with
> ftrace/perf, which they can (using globs in bpf_trace:bpf_trace_printk
> filters).

Alright, I'll focus on trace_printk for now. As I said, it's rather trivial=
 to
add another reactor later.

> @gmonaco: There should be clean glob-friendly RV bpf_trace_printk
> strings so that filters can be easily and reliably set up.

If I leave the LTL header unmodified, you'd get something like:

  rv: sleep: <comm>[<pid>] violation detected

It should be glob-friendly enough, but I'll try it out.

I wonder if string matching brings additional overhead (trace_printk itself
does, if I recall correctly), but that's probably rather minor.

Gabriele

