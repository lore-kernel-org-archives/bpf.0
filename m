Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793926981;
	b=FMNzSNRi4dKa9CB5z9MIPsPrQwVnha3wKMbmdCVoUk4gSYVDBA42wNzNn+G4Y0BJwhrA
	 oalEFyOjzs41jTVL6LgYHiPfbpVYVagdv3DZHC3p/aSp+hYSKvCIFBWGyoi69e4MVEjX4
	 XpqiiGuMRnaN+H4PceNp5Ou76X2IlIr2tRCLzM6itniSZT12sf/uBKBCknLU2rgXA/iBG
	 FGPFSYe6OBCcERAnS0b/kXeKZw9Fg7yd29rBsZkNIe2Y0gbl4srl91xDryxBnNq4G20fW
	 tkTa59XNPgs6P0E2Pa1RgROQACs4YhiUYubMo36eCv5w7PIs1NJhSUYBS2YyaUOtTOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Y0u4IXihur+VBeVt1te8fOm9nT/EPcQisrR3rXoEPKw=;
	b=EeFPT+KCJ6e+1dP+/xMMd6L6QQLQeepwfdbHx5Ikf1iR5KSQbE8olx6sbfktq1cD/e++
	 E5tcirvnybt0UFIjB4D1NeEKq9saQR+F1MMmeh+n5pwU2inWlZzgUqrJoQAaWsvJw1HbP
	 nBIc2gjRPsntCvgfLBjjs8eSTD6MPagE/TFBsePQITGigrKiY7YUZHDfkzmEaOsqLv83z
	 Ni2Q/hvJzl7TdvCdirwCtbTNRmiyhlbjm4lJpu/7UpsPRr4bg0d20xYmvESfrD+sBbJS4
	 ykn1WUhbfVzpQ6tSLynQyP+/cgpFYA5GcplFTuE0cgPfT5CGmCXBuVUvnv1pTPZWNuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l1yXf6B+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.75
Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F4606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 01:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22F4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l1yXf6B+
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-49e2cb73ba3so35532fac.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 17:03:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793926980; cv=none;
        d=google.com; s=arc-20260327;
        b=Un1o5eZdIZ3AWATZcNRcxv6syfsMU3FIeD/kCkQOZEI1muaTGsTUZ41luQCQe2Cnun
         IvZFLY+0/YJQBYqdVeDXUx6U+X/3mhSOmbbe+OL8mNbNyMAZovgmDAxx9+MbnL0SMbnZ
         8wuYYPWN18zzojvRNQ8ZfHvhVlcqnBv2WtZsp8uSrWNwo7Hxl4wEmB6zOF3YvM+pYmu3
         iVyu9t10zRyXE7l/SiwWFgu8vlQAuMp0CO8xUDE87n6+Y8l2B/ZovgpQrGlkM5NtzoNK
         d0nfSbNZBOPHVXNyzX933F4M4vTfZPyslFfriJiXMc3xEz3KjSi+z45gob/K2NG6YUbp
         VimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y0u4IXihur+VBeVt1te8fOm9nT/EPcQisrR3rXoEPKw=;
        fh=wpCVcBTqSL/HpxlnD9LWwVHE9HDRfGKzi7/5aoA+nB8=;
        b=EE/YyLZbQDQGMdeAX8ny1uRBpP/+FKxkM2ac4JsJ8ffnkc2Huep2g4kRcD2E4D8fNn
         JDGHMMmG6tU3CwhAQ4vQXdC6jcCDmwf9yaSeYFH5P4jaByjjFYstzCYD92i3vCPuUcs6
         kgNXhJjAvz5A1h2Iufm+BKNncJjrdld3YqPY/HxoxU8/PJDmNBdFYoxMPofheQefnqUM
         hQ0sb0xRRM13eaNfVDX38ibdDIw5wuMi/Ff8lcmk0nkIgrRuIHC0jO6tQs7x+gJ1L1k+
         G8SRh46LElkcCNodqQZ9QQ0jby9HiNNksFQBP2ODiBedJkmOhqT8c9YBE0BNv1vfnyA8
         Om0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793926980; x=1794531780; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0u4IXihur+VBeVt1te8fOm9nT/EPcQisrR3rXoEPKw=;
        b=l1yXf6B+BJVkocvHAW+3ubMtTVR1zzGaHTvpopNwPZSww6m6rQb5ZHR5IzxfQE1vwx
         A4GP1blH726DVC1ucFjS9HpRpluTwCpoIKosHMcQlnPwbVlS0IOUB36q0oDR1xTiIbyV
         conH6bULw93qo+4G2TLuNNiHliTfZBdlvS/0v3An/U1gYnd6ieD4pPFrG9OLqbl01e2i
         h89mmK+AgZqxph2sS4OAJ+/oUj2cb3yerLGNZ9wcWMZgvt5J6nDag6yhfYEe1L+7JIe+
         lI9s800eCgaFRewL69/RYqmF2LlQUhl+K8LsagJ8LLUz1ZWzziMJdGxvD2Dw3Ds/7G83
         h5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926980; x=1794531780;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y0u4IXihur+VBeVt1te8fOm9nT/EPcQisrR3rXoEPKw=;
        b=WjlT6caZl5HBQpOAyl3lh+IpZy6WZ5PiLlmbrtDxYEY3HOMn3laYIByGk7XI0twDc2
         LQd+fkstI26Mu+I0tCB+pzUDwBVUIxzLmyxKzenKpR1lt4/1FbIE6oiMF7lI+PuOeluZ
         xFkahs+BkoqK3takuN2Xb6CtNAjohlHqwNj9uR8F2uhjrq7JTdkkZQgcNaWmCJPEAXu9
         b0MRRcyal0C3lGV93JoNlzmQxUiyVqh9QenDCf6qqNW0/XKGKF/BCvY6/z/hNHk6DNFa
         /eqku9eZoF5UMj4sdS5s36WqEOK+GAGIus5bg0+My+TeRXaKkh5vW26RzP3AEy0RbPTR
         OdOA==
X-Forwarded-Encrypted: i=1; AKwUvBx5LiRp9428BDFlRSzwXJ+Z7wCcwMtV5v/UmtEklR/CmR12qE4S/5C8zNkZTSaDEp8q4zs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nerql4mIYnZmOFmKbYHu2/la6qNxpiCinGZehLDa14H7blmLF
	K3yi/0u7aMC2YyFVSyOQojuhtK0sQ/pJ+yDzDZ8XpP8SctObYqeb3/atztUoDWU0i95Aa+zGVHE
	FKUmgAIkMDMkj8FKuBeaXisdvNi7GuVw=
X-Gm-Gg: AYBFou2E7OroyfT6/8jyBnrxk0lrXlqGej3GT1F/G6YfZsNHQuBbDcye3AcCwRGkrwq
	ufzIulZeuMzDCjxHScJ5uSzsuqWFZADyF3paR7QjzaqqD1pFOkxhQ7EjevVEhiAUbBQ62pnF7Io
	jIjEsk+h73eyyG9EPiWegjdY7CmJhyZgfVhh2zhy0M/KlD90+FXXUocM3+QvdnxSQaP9yUDXuM9
	D6Uyl0AF3h0Xn+eCwleaHW8L58DC+Fwavg5aO4JmwmvFoQ67/s1/s7pmm9jkYsm64QY47AFtpFM
	npcWklNtM7zA0dngrMlAjIU5qn7RS7SPlXHzpb2bgOKy+wawNtBoGmNFvahb+NKEZExjsam5Rd/
	MVxuqzLU/aS5lPYBqMQATg/0wE+5HoUgd2VDP3cvKhSzSEKPdBveBNKh6LwlmOhcfKCdAE4CPTl
	X7DfDL1FxqBV+2FV7rLDzaUygbgh4ji3+mI21P4Zt9PppnROKZSgxIEQD6LwiYHXLuAn/W3HEbj
	g==
X-Received: by 2002:a05:6808:508a:b0:524:867f:641e with SMTP id
 5614622812f47-567e14c90f4mr843803b6e.13.1793926979673; Thu, 05 Nov 2026
 17:02:59 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101103221.51534-1-dennylin0707@gmail.com>
 <20261101103221.51534-3-dennylin0707@gmail.com> <CAEf4BzaES0KDyhHhk7UguLmRKVWxGoiEXhNvp7QHpeJSZSjbYA@mail.gmail.com>
In-Reply-To: <CAEf4BzaES0KDyhHhk7UguLmRKVWxGoiEXhNvp7QHpeJSZSjbYA@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 5 Nov 2026 17:02:48 -0800
X-Gm-Features: AclHuK8tdnhaPwz3Y54kZitME7BnT6URzVYL1boyOfhhSrmlCGq8Mz92SAE1VKY
Message-ID: <CAGEkeHf9d6BuQWsaqiresmbPNWAVZRbzZv03kfJisT6SQD8aAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: Preserve unsigned enum values in
 data dumps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, qmo@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, eddyz87@gmail.com, 
	ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> how old by now are those btf produces that do not emit kflag=1 for
> signed enums? should we even care at this point or just assume that
> kflag is set correctly?

LLVM 14 and earlier, and pahole before 1.24, for example. Signed
enum kflag support was added in pahole 1.24 (August 2022) and
LLVM 15 (September 2022), about four years ago.

libbpf still clears enum kflag when loading BTF into kernels without
enum64 support, though. bpftool map dump reads that BTF back from
the kernel, so this also happens with newer compilers.

Dropping the legacy comparison would lose existing negative-enumerator
name matches for 1-, 2- and 8-byte ENUMs in bpftool, and the 8-byte
case in libbpf. In the proposed code, 4-byte ENUMs match through the
helper with or without the legacy comparison.

I'd keep the legacy comparison to preserve those existing name
matches. Would you prefer to drop it and rely on kflag alone?

Thanks,
Hungyu
