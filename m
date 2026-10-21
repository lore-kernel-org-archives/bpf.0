Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543367;
	b=oESl7lIa3CXAERaRGktHYUibXlU8MAYRJy/FWxHYJiSET6QMRodXIKDzdaMRt0YPiupR
	 gQsoZjkSOYHi51p4AQXubAFR7ICvnytOWXYhoVCeddcnMJ3npjolgqC+thxyK87mikIN9
	 Lwywknx5GioIS0t1S1AHdV8DEWMIC+1xrAnSq+qMUXWch5VtTAldRKlJ2/rgmPeHkM1O5
	 nweo6LoIiiY4J67OWdn6ardHE7qPaOIoZRD7sJd3yPfbVqfqabKJ6e+AUoDdB/Ar4+gld
	 mjiarSAAJgfAwi+JOClIRTTWfpUrAP3H+aGOFXwTqxDsH9fSaOCcxqIKbL9YORDnJBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=0aCIcmYdJsGIFwcLEWsEZpVClNp+oMWjY2niqzSVXNU=;
	b=WOv3B2j9za/iawzkM1Esw/GXqf0WwcJLgp66NiXueuxspthxqgaLoZWvlqaQ3KzgN3uU
	 yV1auq+FIOBzb0aJUlYA8qcQZuDeOMUzaCPSCqbU4RVPOVeNJ+ztFuheOu5T4PSzaI7k6
	 hydotXC6uz4PoIjCmL2yaoqdwUL2fXUbXqdY1sPf+eUXmMyK95SSfvEBYhrKwaFkdbphB
	 UaxH37fas9zJD+xyO+vLKNNqcabe22pMcv7oKCJEDhnNdltQQlux2pgbjwC1fL9l51pq8
	 9t/kZ2loUiqxKf6lo8G+eHbq+mMi6X5QHltqaqH5rgWEjwIIe7cwBH7WMmXDs1C6vgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=puisG7IK;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B6606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA4B6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=puisG7IK
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so153788a91.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792543366; x=1793148166; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0aCIcmYdJsGIFwcLEWsEZpVClNp+oMWjY2niqzSVXNU=;
        b=puisG7IKWAhqU1a7rYEEgrUaHiwlTaP5DjQFVBXLfjkIK7duCkZJOYWV8NijKq1n2j
         zzKVOGCEvwKBHHKlbRjKxYkDrh/daedq1EkfWk6c00qecap6p5mqOULdNzGORtFxrbmo
         FzAdg0MuEhcbWqhM+kFUVYZKp6PgwDujOGye//xAUuij9qUy41XYgIwSU2IWYWauWP77
         YWhlfIsVfRNxQnYFXxI8zXQ1xZxXouxP8YB1FVI7ORrMmfsSRA+rkXk3EjC9eLXB6qxt
         +sJ6GpIFl0+V6yIe9/8ngLY2sthYl2WPwihxX0SLZ8yn42BH2Lk9pb3wxnzruUUy5Ee+
         rzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792543366; x=1793148166;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0aCIcmYdJsGIFwcLEWsEZpVClNp+oMWjY2niqzSVXNU=;
        b=hAC1MbqsayQtMU1vnL0IxJKVqpIEbwTLsU69mNxXXHeAHrmfJybESz5eTFZsKs2sUV
         afYuFY8IScMhKGPepszxrw5Mfp2tIQYM5R4aIMOsBEJabfUQbp8qo8+MCHntEsfKFDNi
         zTqjR5FgSbVlCJgZzCwyR36aPLfheS/kNnJqUFEHX0A1mg/aWWksz6TshDbdNJ+1iZMn
         HJQFsYFASil+oaSeSq/kfO9y6wNsE8N7rzf4+/a0vhSZBgRkeSdkkTQSTOOLZP2m+hnH
         vcLufYxequM0oBO7YHygvrPQFRclna/5Th1/wS9Y0w8Y6DzpDKNlESxy1DOLfs4K0pCO
         dZCA==
X-Forwarded-Encrypted: i=1; AKwUvBzWldZRg9s3YPaE3th291u69Ob/9Ow0+jBRnwatdhM3Uk4IMnlq2Lfc6ZBdIcSQTUfC9uY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJP21fnOS25WJ0eTRB/F1E2mqSIqqCMSMDv3Tqr0unHyh5qF9C1
	rtu6WWyuIYdeYQbzit6pTPHyQCZxhRHEPHzfPaWCbkAJx9rCV6+JoqcU
X-Gm-Gg: AYBFou3jkUs64EIs5IxmCrRJqWRaAySzirRyGY6DOeCH4dZnO/hg21GDU/7lE9KhbOb
	UG1lVB7PvdY68U0wYeO5dtpCOV/3MOB4Po1z3vO9+RGSp6l4dBTSDZ2L84CrrI3p41QpU/CzBeG
	BbQfq4DkFI2KN2IQ3vyjVarNVL8d3F5jUJDVlCxd3IW0XTtlV0hRI5AIrCBDSBmfUqv7ArhjPcc
	9vdWYfpWv3YC636PCvcfFxwzGLE4s5h3l0tdbA6U7uIUQ4/9HZTqo41n/L+U1efMBw4QbvEXuWP
	V/fSv/Xa/BU20i5JC5cpnLHxP4+U8ktx+/OVOHY79jxibsdxUuSk0PpNYcWbvicHIV8lhJ1R3vx
	gsb2xRQJpEvgMVJZ41rooY4NcixrCtjqBoJctqwDVx0DGhKbM5G3Ru8QOqYrqzULy9tb3ZgVshb
	humCKOvQbeXFwqM2gZsVfxI+RRM/PoOOSv0x0IGmRv7qExdHPxRXDh7pqkzdJm4H77LE2MDdV+w
	gi82Dom0KSfCIg6Sk8dAamkkBax2EJPn+Kl4zF87TsXPgMcHYIqI1MzIJbGYUCCWy9amqcy3MPu
	BLNdK7Y886mW2vXhEDQ/5cVzTR5UHAbnp7XGX4BtDKNv0Fz2GOuJKzSUZrBDWA==
X-Received: by 2002:a17:90b:2e52:b0:3ad:4a8b:c701 with SMTP id 98e67ed59e1d1-3ad86f79963mr412456a91.45.1792543365952;
        Tue, 20 Oct 2026 17:42:45 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85fc0cd2sm504176a91.4.2026.10.20.17.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:42:45 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:42:44 +0000
Message-Id: <DMA3L9A79PD7.DRTZ2IXQUVA7@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Cast helper IDs to the helper type in
 bpf_helper_defs.h
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Maxim Skokov" <skokovmaksimevg@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261020101229.111074-1-skokovmaksimevg@gmail.com>
References: <20261020101229.111074-1-skokovmaksimevg@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 03:12 AM Maxim Skokov <skokovmaksimevg@gmail.com> wrote:
> Converting void * to a function pointer is a GNU extension in C (gcc
> -pedantic: "ISO C forbids initialization between function pointer and
> 'void *'") and an error in C++, so BPF programs written in C++ can't
> include bpf_helpers.h.

What C++ programs you have in mind?
Since today there is one as a selftest.
C++ is far from being supported.

... and including the header doesn't get them far. bpf_for() and bpf_repeat()
in bpf_helpers.h initialize 'struct bpf_iter_num *___p' with (void *)0,
which is an error in C++. The bpf_iter_num_*() externs there have no
extern "C", so the kfunc names get mangled. vmlinux.h doesn't compile
as C++ at all: struct page has a field named private and struct device
has one named class.

> Tested: the generated header compiles with clang for the bpf target as
> C, gnu++20 and c++17, and with gcc as C; with gcc -pedantic the 211
> function pointer warnings are gone. All 1082 selftests BPF programs
> build to byte-identical objects with the old and the new header.

Those are all C programs.

It feels to me that you're scratching the surface.
We have to see full roadmap to decide whether we should even bother
making these steps.

pw-bot: cr
