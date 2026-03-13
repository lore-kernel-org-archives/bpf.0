Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9363914EC
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441923; cv=none; b=bJXN83s1aGJy87lDpuLG2thWyaiD6eCQgZGDEzyHe+C1g68WxiYyvpL7bdVacvCgMPpfkdHfbCmnGyKqscZA48MVG1umHuLISGjTQmUuBaK5rgvOP7x1eGGjfP6ZBsLNiNlbQGZeAot99Y2fSviIiDxsnNBaj1YEZBhGIBjDNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441923; c=relaxed/simple;
	bh=+lbm/ATdbBwyxJrhgQqOSgn79RoQv+gHUyhf612IP7M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BqPOLqgb4dpCVllP8R+IZDdNIPtVEWFDaHmfoZe+f5Tz+4bqcfLCp7UIMWtkZ79q+CDRE7SJJ3AMPCvaRz4nOf9DgLkEypZuDBtotHi3NkWZjwkwkPz4dcInx36YRxBZUANHGxATddg1YNH2ImVCtWjjvTBZw6BifAgQVMug+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c15NUNd0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c15NUNd0"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8296dabef74so2595255b3a.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773441918; x=1774046718; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+lbm/ATdbBwyxJrhgQqOSgn79RoQv+gHUyhf612IP7M=;
        b=c15NUNd0egjzMkow1T95bv1EBaMyTH5LdCy+KN4nxyyUY7pY9Cj1zmdP7TVUnTlBlf
         BbcBfQyePWFg0vPXyYrQdcQnp0TWbDwwhwoyZXZ9Dymh1TCxxsUEyLreHrZ+D6c7Ptl1
         6dKN/YgJrXKQa+Wx6BXvB67X4+7iyuLAen4n5PEvpnXDcQypQZX0orr5InLOoF8a1z2r
         y9VYGOE/Bi84vUthbSk1EFzQcXjgl0qNjjgwKxGME4bI3adqQvVD/+ifGji7TgNExHbG
         7pCPjEzPVVLfVDN5SKfZThdU6p4O01LrMFebGSykz54FqQYeORV2h5SAmAzM8ZOwi8PO
         NqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441918; x=1774046718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lbm/ATdbBwyxJrhgQqOSgn79RoQv+gHUyhf612IP7M=;
        b=OFgaCAkS3nUFLn9C8RavwfU7NNzPGPrTBP9FUFYlSx7hKR0N7ibvu1TSOYbK4Iu7NB
         peAJirDFYaHeGEf8Dt6W3nKjBkpmmsWWiuB7Y3L/QgIkNdGmN+GnDSjMpcwNtVQ5K/Xq
         cVYP8w/vfKsYgTqqlIALmDGNeZJFa5jgj95KZFpOCuVO6zjAGniI8O6YP447m1jsSIPA
         ++XhvS6hvIVGCB7aUfnxQN7MQc240hGQnYNv2aN3u74oB7ejF9Dn6yDp5LzMtBPwkehr
         J2N+sCw7Z6GHWzqTIEtDXtrfF+KTFHlDQ6IZzblbIWhS/VjtUxOSGB410aRd45TuFFFr
         WnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL6jLqdYclFQstSozfA2tK2BCaCOjqLK0GH4MBtKAisBjUw5wvSF75eEWeYXhaWQ5GUK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwahcNlk0WpLp468V85nKGg+TM5m0xSJ7RmZswaMJWk+QPTcdz+
	ZnHKHOnZb70Xku9bFXGfehJsC9YTEAExFCUBcenhdKqFE/yNeb7ue1HY
X-Gm-Gg: ATEYQzwQFZBkXSMAMNBZ46+APiQ4qSS3O4debUCH2TMvUvbvyAZ6VpX2XxLbMYszH3U
	w8/dgXkHez8CBVUKWOia82qUPxD0+O8S+NrCbd6+xRGI54A0d7VB1Hq4vXrT1XAy1rrkL+doXUg
	IOU9pQxkAQmHfS+wH4k7KZwwcf5hFvztV6XG0AzDCqI0xOxMC+JKKOW5wXTBYCYhFDvg+VzPA9A
	GTwXJbEosvGl9G/Fhzr/BdS1oq2wa89OQ/PVtHUICXAtIyoyGTWFwd8NaxZrjHVokbQ1foRTV/j
	QHFChqtcFBfjTo2N0Fp4l4o3rndQEgv9iOcNTG868A73pb+v6ZqRU02h5xK4EDbsaQxyavSM3lF
	5lX7wnraT+JbZP+p0bzoNegJ+wGG0AmDpxCOgWLdBFOoJtSxZmdN/FnkMKGnWVIF4GhBZmnAHX/
	IDIBuQLJibKYaFufRup49UkxttLHQAjzwE5eldK/scf9X073olcf0=
X-Received: by 2002:a05:6a00:3397:b0:81f:3f03:6846 with SMTP id d2e1a72fcca58-82a198c2507mr4271445b3a.47.1773441918567;
        Fri, 13 Mar 2026 15:45:18 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738bca8sm6685750b3a.60.2026.03.13.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:45:18 -0700 (PDT)
Message-ID: <1ef7dfe4b301dfc54ee01f599120d7ae7679c6bf.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix unsound scalar forking in
 maybe_fork_scalars() for BPF_OR
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Wade <danjwade95@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ameryhung@gmail.com, ast@kernel.org
Date: Fri, 13 Mar 2026 15:45:15 -0700
In-Reply-To: <20260313075318.11847-2-danjwade95@gmail.com>
References: <20260313075318.11847-1-danjwade95@gmail.com>
	 <20260313075318.11847-2-danjwade95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 18:53 +1100, Daniel Wade wrote:
> maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
> source operand is a constant.=C2=A0 When dst has signed range [-1, 0], it
> forks the verifier state: the pushed path gets dst =3D 0, the current
> path gets dst =3D -1.
>=20
> For BPF_AND this is correct: 0 & K =3D=3D 0.
> For BPF_OR this is wrong:=C2=A0=C2=A0=C2=A0 0 | K =3D=3D K, not 0.
>=20
> The pushed path therefore tracks dst as 0 when the runtime value is K,
> producing an exploitable verifier/runtime divergence that allows
> out-of-bounds map access.
>=20
> Fix this by passing env->insn_idx (instead of env->insn_idx + 1) to
> push_stack(), so the pushed path re-executes the ALU instruction with
> dst =3D 0 and naturally computes the correct result for any opcode.
>=20
> Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the veri=
fier")
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
