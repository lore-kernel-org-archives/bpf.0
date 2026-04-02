Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1C3C1980
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168227; cv=pass; b=exJIzXPW1CqoWBIgBezIr/gnDhhzwLx8gQ+lA4r5mTwuqHWL8BnFBvJ1K0s7hPUp1GnOV5Jwrt8CrS6w2MdyguHVHy7RfoZFMr1cXbW+VZ6P9XUPvuYxfCE54EDMy1XR7G1RZyUYQ4aSrET2dGpHG6oAuYOL+vwNxp+dObT4hHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168227; c=relaxed/simple;
	bh=D74NIeqCV12XgacTeVqSlj7cfoOfDrGnIkkOLsDzhis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSEXMcC8EARYPGB2akCB3+GQ9W+P8BQrcvUbJ6pFAIchZoCdCc3y9+iLjudroOEf4U5XL8c1niqFdwHpnMbjrVtVDXpYVJizpY2/TduulGi/LWNfPaiLqBJXYmNLqlru1BEN3Ba2+LFUDt0+IKA6NY1mTZNw6n+7ewAPMKN3fXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0dKNO1J; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0dKNO1J"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfb723793so912575f8f.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 15:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775168224; cv=none;
        d=google.com; s=arc-20240605;
        b=hCBiEELLH4TF/VAk8fID3IbWGF3oFdSq3gKbZYnxpG1i1MOP/gyzzRXKBW+psplRhs
         jzkoZJMKTyaG2stHbJrmLJeUXozEu0lrk1NbZumWqF3+hkanW7+ru+VtIY/ObMZEPjDY
         OIxpO8UvgARmac3XpsyKv3WPnFKSlkChAvSsvf32EoQ047EDhSwz4zkYezTLchcfg8o2
         tZ+sOk1p7UJcN9a3kV7Et+miYYJJxny865T7gOvi0puo7xBINcjai6hIyKyuSxF3Xsp5
         CptBfNNGMb+XNCyLwGtjT9tP9nnQqgpH0miXEuhq1BIV1i7+DQYUYKSLXC33iXM/FDyg
         rTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=amUReQ3ina2wYCV6xiNTIdpbjblXyyaKv313NH2tmJs=;
        fh=bVZKQ0C9zZCVFVT8EGwyYXaHS8v2OVAOOqZR2PKjS4k=;
        b=ScCkQq8H/1mxDU9raS6qjcN+10VqNf2r+jpWWwIpTkmylq+99W2iYrfNxaRD/iR/vj
         f2QmPHu0C2G7T8n7HLTlJ2+8jVYlCT52VfjgX7YR3UvB9Lrhyw8muCxbod52C2zjZaEf
         VRHlNsAyPvZPMoBCHUdrsHGDGmn+RQMzOkk2v3AUrULybp7n+0O14fs0PApOIdKFmS7E
         1Z+E8mFANXBcSKsfnixT6WlEmlE80hBr/n13aurHJMRHPpi5j5DxKXRS3vLxHP9tcCDY
         MO6Q18+E085Z06RW+a4r+Vo8jIIAaISB866SFlptihmc29JYcQ/KwYJADByzfKzJJItc
         jyOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775168224; x=1775773024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amUReQ3ina2wYCV6xiNTIdpbjblXyyaKv313NH2tmJs=;
        b=P0dKNO1JwkUrGPdExcmDWbX9pndQjHO1iU3Vz/VfPbaH+yv6WZETtbqn1l9b8kAnb4
         VW29h0KdBDYHVCQuLoWz/XsUN34EgXmT844esmG+TjdKb8AQvMnzqs2QRkOFfpojntlB
         cmWTrJNWblXPhLmjVSkGWtsh9cgD3rqEhXV+AUzZj0/WvhMn26U2ZkgJsgsQFuhbrMfK
         nL3K7nGKb6fmfbfXJfTxU8kPby9Ai2kbwIBPUNPfQiz57HebgCLtHrQbVgJ4Vec5hsoK
         S1Vy+y2UMQUsykJCwlM0mXqrCQHbH9eB/pS8fJQKa38/fMlWEy74f2iNCA/XfG7+twIW
         /ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168224; x=1775773024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amUReQ3ina2wYCV6xiNTIdpbjblXyyaKv313NH2tmJs=;
        b=pA4LzPiXtnME2kRXhAYy/idTi+wt/ZMEQKQ6+vr1+0lWV+T+rLK/AJuw/R02C4H3Sz
         zzcAcNvY+vkrx0/J5zi3lU82zHchJ8wjMfMq6C8lHssZVvswYmB44SbPVaNdOsqF7ur8
         DHAPsoggrSZGrQH/INHlupPbL6iepLpOmlATc8J2x8mPpGnFucLIbF/1PztY8tFNHsUZ
         JVSgup9oXOunY3Al2E3RPq7ygnk75rYkFB1XPEQS7ulJhDHNtVGrV63MlXLbxWkP9jw+
         j7JLoasIKs+yVieO5XRBU0f+5inKITQ3AsWoQQie8E6zOc9F0BoEvKAMLRYXlNEkX/4q
         9ohA==
X-Gm-Message-State: AOJu0YwzI+YVVROKFC+endJotXDjx+Pqyviwbh9GyhVzopP5lR3uSFA0
	6haS3B5HnsdXktzljFYOTnm8mzO21fZqFQDNW9VgwUe4OcNtX7+ZJTUuxgse+C3fLclw0g56VcE
	9F69bjLKrc+0tfRNptmqIHs6GlMmU1RA=
X-Gm-Gg: AeBDiethm23blIJhHvgCXhojDC37f0K6fjlCNzkcpwROmaLL2ZEoZRmGcrvxnTUryQJ
	KZjlu8LUWuyr+Ye1BQyZSdWU+mTu6OX1x0otA0wkWMOJcVBI5vjKEh0r+oSFEk4EnQtZFRxsCji
	GL6p9/yEZTxPXWTcQbyRbWqVw1PGG+3a0pkIKt1gHS5wa80Gup2E20ymfDMvstSN7LnJloBQ7Nu
	LBmJQhPPb7d4KiJu+MCaz/Xt16NNZX9nBNzKjroj6a3uBjMWRgPJQJbrkkI3E3FHPzE2e9Pwsri
	JQY+gaNBssHtV/2E2d5jNEj7vslUZgg6/BoVi4318Qt5sVi8GA1OT4rgt2s7/y9V8H+rurCTVo5
	9a0t/rQ4YX0knn5JaB/5c16HzAQ==
X-Received: by 2002:a05:6000:2885:b0:43d:1deb:a5da with SMTP id
 ffacd0b85a97d-43d291e2378mr1111490f8f.0.1775168223755; Thu, 02 Apr 2026
 15:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326205050.2826760-1-jmeng@fb.com>
In-Reply-To: <20260326205050.2826760-1-jmeng@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 15:16:51 -0700
X-Gm-Features: AQROBzBFdYPIvC-K1hkkL8GP9Ed-ropcjOBO0TdBJsUswR08jw6d6fPapKdjvKU
Message-ID: <CAADnVQKXio6nh+3OLkJb3C5FyGS404ZAQEPpwxVD6Bsr444ahQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/tests: Exhaustive test coverage for signed
 division and modulo
To: Jie Meng <jmeng@fb.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:51=E2=80=AFPM Jie Meng <jmeng@fb.com> wrote:
>
> Extend lib/test_bpf.c to provide comprehensive test coverage for BPF
> signed division (SDIV) and signed modulo (SMOD) instructions, both
> 32-bit and 64-bit variants with immediate operands.
>
> Changes:
> - __bpf_alu_result(): add off parameter to select signed vs unsigned
>   div/mod semantics. When off !=3D 0, uses div64_s64() / s64 modulo with
>   truncation toward zero, matching BPF signed division spec. Skips
>   divisor =3D=3D -1 cases (handled by verifier).

isa is using 'off' in encoding, but that's not a reason to
name variables in such a cryptic way.

Add another bool for signed vs unsigned, or better yet
convert bool alu32 into 'u32 flags' and have meaningful names
enum {
  F_ALU32,
  F_SIGNED
};

then all of the callsites will be more readable too.
true, 0
true, 1
false, 0
false, 1
are hard to read.

pw-bot: cr
