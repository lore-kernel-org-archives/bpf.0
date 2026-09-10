Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540873D9691
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030856; cv=none; b=cMIdRhxvl2sYGiGTel7wDLPYTQvicG2KBWowbzC88U/0Wz++P5/hwfLIgANtZtLgxca5HVhYe9Mpgzt4JnTrC/kt1fQ9UNi3P6UHSkDIcu6ABQKLiTYaUBpQq1xlwW3EYK7eQldiVloUyIu37dDWzq6qvcjqobJxYoyM+CDCDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030856; c=relaxed/simple;
	bh=r2ERtI6ml5NxXFYRqY+kl69JfEx9qVlx5UIKxXympuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7ScxdaNz2jgNcsunnD39OQ939v7b47jVvRzLv4B9TI6oxAn38pyyCJGV81XAZoEicrCquJelwBLy1EA7c0UWzg8Jjo7i9GsOHaHSyKLkXTJSCVLDgw885eqCthnTIY5gChyP8ELHfPWTFu4eju6Ih8Uv965g7jjDOizTD9BkJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7IEmC7B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jaQSI1aC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7IEmC7B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jaQSI1aC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789030845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tn7jiwjS+8AdQjcpXNuBrdgygnnhCmQHZ+dQYaJk7Cg=;
	b=Q7IEmC7BgMXBdm8cSXewSPxGw2ynqZC2/Lrieqte+fTQ5XXiQc/KdBPnH0cCYahDrz15F1
	lq0gya3mhPjhVtXNP9hwf1+61jkEwUHyGuapMAW+BNCmT2EvNQhuBiI2askSbAseQpm9sy
	4ZwJSqNKHCW+7A4Sj5uN088gzGY23s8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-4Fwl0VmuPMilF0LljfARUw-1; Thu, 10 Sep 2026 05:00:43 -0400
X-MC-Unique: 4Fwl0VmuPMilF0LljfARUw-1
X-Mimecast-MFC-AGG-ID: 4Fwl0VmuPMilF0LljfARUw_1789030843
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c25501f4aa2so98979666b.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789030842; x=1789635642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tn7jiwjS+8AdQjcpXNuBrdgygnnhCmQHZ+dQYaJk7Cg=;
        b=jaQSI1aCAE1ACip5nR9ib+BXtDgOittHKHoyLoM+bfgjeGgIkar+cR1HXWGFHh9UVe
         zGSbOJa0MrC1+Qz/I8UIMAu+jiEXuC1Nk4IfvZ+alCNdQgNOIIdgyaWkJVKqwwIZfBuz
         OE5K/1X8mQjzZnGL2IsjoJwHxFEvqtEXbghNBX7zteJQsdY90JCSex5xBp8xJxL4QAZx
         ILN8qa9xhZnCrnglNcvDhcJKPAZcIzlz8TJjvRT0RVAQvJzUlEuANgCBQ8QL4GzZa/aQ
         ZCHUnzwen4wYOnWjVtQ+3RVICLC0RCJEJkbABl43/Vs3xJzZgpZbEFQK+j9aie9kMgKp
         jSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789030842; x=1789635642;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tn7jiwjS+8AdQjcpXNuBrdgygnnhCmQHZ+dQYaJk7Cg=;
        b=C7wxJ5Unpi/65AMulj/8jysmhv5EmbmAdv/i1ewBeeTQ93cR8TwlOcApVyA+1+1MCT
         V8m+jMnqpquVbo1TsaIRZkh+qdjeMd22uegBrBWoc05X+XV1C2I041M8E4g17M/QzZEq
         ut4WapMrjnCQm6KObRXt6efciO9I+LbdykqCWoKfdOI1d3S64ypDXMYu2MXA2jLLVxze
         9IUTZq1K2C6wODlD65cFGWOu5VVH2ZDwUR03UHsGP6g7Ke7Pv0xWTeKzOLZ7i07SOCc+
         r2XXfLZvm7D5QFWPi90iedsmIy9clWZlcCy1nb55/vtqid0UckrX/LesbryWI95BEC3R
         ZLJg==
X-Forwarded-Encrypted: i=1; AKwUvBwgg4EmY4Nrr2v7e2tziSC9Bqb71nhbXuQS0Ag9MtijQ/cWoxaSrJufOAFInc7JmUDh7DE=@vger.kernel.org
X-Gm-Message-State: AFuF++lpN0YFFlYOQxeNDuwb3UA1OQidOxuTmyT+hY4XdiFHhYfElaX1
	aa9ZDuXsaGJpgQUvNu3DwHg078d8ty+JizHwTKbOLwRRqGMpAfMgkUU/irv1VRWR6MDmz651DO+
	GqC3YK2Bwa4PRqvvqdHPfH7DSjPyWR/T08Y7Rx3VCquriG3lxNHe9wA==
X-Gm-Gg: AYBFou10UgxEeCV7kCe+qUFAdQEn8fjZi+uUobHD2NSfz8m2oTndH5Ayo2/Rcm5A6/p
	GAo0W0oryp8crN7lNzc0sUv1yGSLJ0pr8fcTf/kdwCqZ3HabSxZoIqRasNdCpWTeMgrGbT5GZ9/
	qi+p5m7lhz678Iu2lXrIQVAp2xMMgK6w3P8P5zL9TNFhyzEsUes0Yw3/x9vDd/Wj8v+T9Yxqd55
	UpHh7SOqrYRUHqxzXWyvQSVRF2GEuMLrMbViKEbX/pG31Zr/s/RkevsymqXHi6g4C1TK7k61VTN
	kUu9PNhJtPwtICJNO4lZWgHGS0+Amvp3igN1sTyS9d56XNThzxZG0z5d5SomtPuvX3bRPY9L8uV
	xDIama87KZA==
X-Received: by 2002:a17:907:6ea3:b0:c24:6382:2648 with SMTP id a640c23a62f3a-c2945dd4853mr193765866b.5.1789030842539;
        Thu, 10 Sep 2026 02:00:42 -0700 (PDT)
X-Received: by 2002:a17:907:6ea3:b0:c24:6382:2648 with SMTP id a640c23a62f3a-c2945dd4853mr193760466b.5.1789030841682;
        Thu, 10 Sep 2026 02:00:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d501662sm896809466b.23.2026.09.10.02.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:00:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 226799B972F; Thu, 10 Sep 2026 11:00:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] libbpf: Add bpf_program__add_flags() and
 bpf_program__clear_flags()
In-Reply-To: <261c5e00-31d8-4090-aab4-a633924d336c@linux.dev>
References: <20260903092416.223294-1-toke@redhat.com>
 <261c5e00-31d8-4090-aab4-a633924d336c@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Sep 2026 11:00:37 +0200
Message-ID: <87jyoteb0q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> On 9/3/26 2:24 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> When changing BPF program flags, applications often need to just add or
>> remove a single flag. The bpf_program__set_flags() function clobbers any
>> existing flags value, making this awkward to do non-destructively.
>
> I think the whole "non-destructively" language in the series is misleadin=
g.
>
>     bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
>
> does exactly the same thing as=20
>
>     bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV=
_BOUND_ONLY);
>
> That is: overwriting the prog->prog_flags value. Where is the
> non-destructiveness?

bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY) doesn't overwrite
any existing flag values, but bpf_program__set_flags(prog,
BPF_F_XDP_DEV_BOUND_ONLY) does. In your example you handle this in the
caller, but you have to take pains to do that (which, judging from the
fixups I had to do earlier, was not something everyone did :)).

However,

> Let's call this for what it is: a convenience API.

I don't mind changing the description - will respin with this change.
Thanks for reviewing!

-Toke

