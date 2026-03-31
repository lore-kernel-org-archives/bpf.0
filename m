Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C813321AA
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994590; cv=pass; b=TtjAXRZ5sE8qAWsMpyW81A8C1pJ4KN034mVpwPOPTW+Ac/UGm+IVYflvaW9OW5gUQG8JVpBLabCD6NyFxwd00I4rmwrwPAlm1fCHDrzwKfcb6gHaNO3ciaCvJKP7mfOZGp5Iojg/npY2PoixtH0eTpXmXmvJxbjLbXM8rRC1sco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994590; c=relaxed/simple;
	bh=3KBcXTj3foBitdpV/hjYRSKEsEqjRkebTZLmioN5hko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l19R7n4IBvQubvnPvYTUvjGjoToeyFk1TKLOyGQTKTDLRE1ShYDliefMreqWiSkXEKJcYQSd7/ipgMAaZf/0xmLNEu/H6xCo1dX8rp4LKL7bJQ2JipNpo4v+ytnDc/I8EcWcxEQEyGbPfxxWdrS4aVLBzXrHb0a5qKjyHOn7Ep8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeIkX3Zl; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeIkX3Zl"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64d5a7926cfso9343181d50.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994588; cv=none;
        d=google.com; s=arc-20240605;
        b=iARCHXjjD50NxrBegjNcLFjfmQ3xAsAENeYlOIJLJgCF1Yiz5Gf9q4xwduyPrg2byq
         bf9BGtsJjM9GO7qZ8q50ehlPCi9F8vLgWp2GbpyDZbiVKEP8KvwOu4w6z0/LlU9RMBMz
         H5JlhjbLQjxABLGOOr9gaGGbICVMbtiq9HPnzb0ynVEbf5/hTZLBiVu9F2WjUhQdhQDS
         Hz8Cgk4x2QfdfiFRyAAQvnnAUcL8ot/cT4j69E6U3P+vSMQHpk0BggZMT3zq2juGhVTz
         GZ8xorQpKYiUKEwaofRiPBuwJVp+26xO92t8Fk56sqOWZJ+eeVGZ2sKdz120cBsvRfST
         pRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3KBcXTj3foBitdpV/hjYRSKEsEqjRkebTZLmioN5hko=;
        fh=Hw9e0sGuEjSwWdLL3+OrtdZzswG4pblvAVFzN0TewB8=;
        b=As0sG9KSzHUaoEYkyXND9xnen9Q+X4tGeSLw6l+LdEDm8QdEc7+1EVX+74qi7NWojS
         benJ1qoQ1dlPD0EpFbPmfIv/PXZSuMw4qWojnW+IHDo3M0QSqPUznlHk5vaIhrCoEAX3
         3B804O/ln0SyM54aIcp8VRQluemR6WlZ19E1xTOGC4mhEzfiQSoDiezY1XroNXTWsc6M
         /dDc4LfSWMJvGDJeQi2iXCXOJRkuR8p+hRyrgUzyn5VBrp+FkWrd+SQ7R1Y1pfjvZsg+
         m0PNn7xB13upj9epZrDSqugbFjiTwSb7nzdc+Uc2O5LaedZ36ROrD3oS5kl5Algp3d95
         Lu5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774994588; x=1775599388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KBcXTj3foBitdpV/hjYRSKEsEqjRkebTZLmioN5hko=;
        b=DeIkX3ZlQf6jq6czsUz158mAAbE/ZzTjd47s8GGKh6PRzfRq5t+xtk5ojOGtycuMJT
         O7ckGHw1iD8VfcXiIbz09wNr4udVF66vwB/uTEQu+IKTaZwmlttMcc58JkWOJCtUlmhf
         tMHxa6DK9X7AmIiVVqoIvxLsta7bnOO/m4vj/gTJ6j7kBIai8mFOygV0Smi+CxMa0Das
         z1LXpbwAhKhyPsJdcZsKAw9f62gESySftYDTAs6ORe8n7N+fnOlilRN5i0MSLi6+V1Zs
         g5F6NIQ/S59zuHJrOh7aB1OqA7psJ9gR7t6dQCngDBDDijxCInldSD+Ad3LhLDcsycm6
         /uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994588; x=1775599388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KBcXTj3foBitdpV/hjYRSKEsEqjRkebTZLmioN5hko=;
        b=C4FXmWyo5m3Xz+R5jzjNEFFeBS8aU9lMBL1ZujPc3M5ejFLZ2FrY2zcLjJfrwmLiA1
         VDssD+k/DuG0DVUtmbZiiQ831/DLuSCnQ1NTJxgOY2TUiN0mDc9O2kGbIGPMmJpdTFn5
         yrpx+6yuYHhFKuppCrHVIk9e/L6cR+yjNbvTP8+vaf5EdAs/Ul2nA86tcn15uy/3onIn
         trjbe6zDM2HOgEI38qUXjCCmdE1V8WddU46QTce1vnfGc3Fm9dt6icU0mwc7ezwYSrzj
         K4/91cwXJb7w9odhVGMA1ea/PWwEq60+28G1/ApMzfZhvhwdIp8Fdu+6DgPx/DZH25N2
         sEpQ==
X-Gm-Message-State: AOJu0Yx1v5Vr7EpIJxftWNA/vz08Clkbz4Zd9aftO4S1lkSYYBoxtk6z
	X5Q/an3Wj5oGjgDCnX8NYtp56tRh+E1DWk77YL0V2bKmDFwaAYM7MhxCrB01g2YghgyG9IGxreF
	1ifMiTKCqrFZc2OQwlu4WII3new5u8WM=
X-Gm-Gg: ATEYQzyvNtlBw09hqs/IBBQjJNTv7b6c+VA6JGhJegF2WT3dYY/GraL4Rw5hoZjXsjN
	9z0j8taUim5P83LEICdmLCZcBdsjd7nyUxJ2V4+ZClS6UcsvaNwjy0SRzYzaVESDdx4qvg+tKcp
	uRsm1jqr4PimGawRG0hww1cWhjFYmswx5AGHjJkEjeDyMaQNQtnC1rW8Dt3wIlKVSP0Xgu4xjEC
	0pJ5F+xJSkSonpIFPELWVosFym60adGMzNFdrjrQOEabLpKek+4DdYe06E4UAoDpLIF3SiMucAl
	opXxhc0=
X-Received: by 2002:a05:690c:9202:b0:79f:fcca:aeee with SMTP id
 00721157ae682-7a20f5f4d30mr11255867b3.1.1774994588173; Tue, 31 Mar 2026
 15:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331204228.26726-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260331204228.26726-1-alexei.starovoitov@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 31 Mar 2026 15:02:57 -0700
X-Gm-Features: AQROBzB8Fmcc6vDhzptsBLjFZ2IwxfMiMUSWz5SIN00YLEiUad8HnjWIqq1JdbQ
Message-ID: <CAMB2axPvRNJD20_Ay9NDMk8=d4toY3jFvb6hXVfdn_v02kWM8g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix regsafe() for pointers to packet
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 1:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> In case rold->reg->range =3D=3D BEYOND_PKT_END && rcur->reg->range =3D=3D=
 N
> regsafe() may return true which may lead to current state with
> valid packet range not being explored. Fix the bug.
>
> Fixes: 6d94e741a8ff ("bpf: Support for pointers beyond pkt_end.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
