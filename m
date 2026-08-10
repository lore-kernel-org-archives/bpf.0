Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970643F091;
	Mon, 10 Aug 2026 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395919; cv=none; b=evFEjyvfTqXg1ZZueapMiF2mVfm4dcgWuVufINf0d0gpmnHKX+P0Y7tx+Y0jdGMnd5HaA3FcOkEAauMCWUoS3FwBOE2O0vh5O8r1Inmw2wprhcc9oGG7MMBuNv0YM1reN7HnyaukPBpvZd2aw26wZLVeLYP0lP1JheZ1fLa2mOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395919; c=relaxed/simple;
	bh=it1EKwnKeCRvEio5ssY4N9RO2q3hwVoeDVOCQfKLVB8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G1YR/8FMH12ryDJq0sZFiCl40Bc2caZEy8D0Uc9w+hHNtMBDhKKKQ3QhU2S3KjmEUJ6hUqtfGrMT/9xefen52SUpsM/UGRsqR8tdNbO/ClEQcXQJ4G8MOsUVdlN1UFCcKwqy5r+b/HbVn3kd/7otmD3MXo/OTMM3xkC8Po/kS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7T4sYlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7T4sYlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1444F1F000E9;
	Mon, 10 Aug 2026 21:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786395918;
	bh=18dzxLZ7jA6XeVHBjBY/ZNrRMBq/1lDCtDHH3C8d4N4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=W7T4sYlkcZlBiWu2dYzx7Y7ycTLECSaIlZrEMBcZnQ9VfQu+ED3pZNVC7RYgU9n/a
	 SIKn0U8ex2hIiTrDbxjxfRLOtcbEFUb51ECj+iOa2zDA1gngCDjNtkZGtrS51tn4Ya
	 TE+WZnjhW6Sh9+SH1+4wPs8lHhxTfhKSBHT7ZLLV4KeOdqrZIv52uDuQWHzcObpdBT
	 NiaDku37MVL8ypx69tjcAS2wNdtDSuu9L7wzGoVUo/hwbuo0i6tt3vfvkLwEe2fhMl
	 OM6lk/PV34hkKW+JrXOhAatdSfeINl8ucV10DFwS+7phH/HjHMFEWb2T2GOoWpkHWZ
	 aX8r/0IA+LDAw==
Content-Type: multipart/mixed; boundary="===============1828966171191452426=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0a3e37e41b717349aa88e1216d9e821ed47a60a3780f2b0fc2844ec3d1bf1a3@mail.kernel.org>
In-Reply-To: <20260810194215.3754591-3-main.kalliope@gmail.com>
References: <20260810194215.3754591-3-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] MIPS: uasm: Add signed div/mod emitters
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,tsbogend@alpha.franken.de,johan.almbladh@anyfinetworks.com,paulburton@kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,philmd@oss.qualcomm.com,bpf@vger.kernel.org,linux-mips@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 21:05:17 +0000 (UTC)

--===============1828966171191452426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 125140979d62..06d722665451 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -49,18 +49,20 @@ enum opcode {
>  	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
>  	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bgtz, insn_blez,
>  	insn_bltz, insn_bltzl, insn_bne, insn_break, insn_cache, insn_cfc1,
> -	insn_cfcmsa, insn_ctc1, insn_ctcmsa, insn_daddiu, insn_daddu, insn_ddivu,
> -	insn_ddivu_r6, insn_di, insn_dins, insn_dinsm, insn_dinsu, insn_divu,
> -	insn_divu_r6, insn_dmfc0, insn_dmodu, insn_dmtc0, insn_dmultu,
> +	insn_cfcmsa, insn_ctc1, insn_ctcmsa, insn_daddiu, insn_daddu, insn_ddiv,
> +	insn_ddiv_r6, insn_ddivu, insn_ddivu_r6, insn_di, insn_dins, insn_dinsm,
> +	insn_dinsu, insn_div, insn_div_r6, insn_divu, insn_divu_r6, insn_dmfc0,
> +	insn_dmod, insn_dmodu, insn_dmtc0, insn_dmultu,
>  	insn_dmulu, insn_drotr, insn_drotr32, insn_dsbh, insn_dshd, insn_dsll,
>  	insn_dsll32, insn_dsllv, insn_dsra, insn_dsra32, insn_dsrav, insn_dsrl,
>  	insn_dsrl32, insn_dsrlv, insn_dsubu, insn_eret, insn_ext, insn_ins,
>  	insn_j, insn_jal, insn_jalr, insn_jr, insn_lb, insn_lbu, insn_ld,
>  	insn_lddir, insn_ldpte, insn_ldx, insn_lh, insn_lhu, insn_ll, insn_lld,
>  	insn_lui, insn_lw, insn_lwu, insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi,
> -	insn_mflo, insn_modu, insn_movn, insn_movz, insn_mtc0, insn_mthc0,
> -	insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu, insn_muhu, insn_nor,
> -	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb, insn_sc,
> +	insn_mflo, insn_mod, insn_modu, insn_movn, insn_movz, insn_mtc0,
> +	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu,
> +	insn_muhu, insn_nor, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr,
> +	insn_sb, insn_sc,

This isn't a bug, but the rewrap of the enum opcode list leaves two lines
considerably shorter than the surrounding ones. The line starting with
insn_dmod ends at 55 columns and the line starting with insn_sb ends at
25 columns, while most neighbouring lines in the same enum are packed to
70-80 columns. Would carrying the reflow through to maintain consistent
line density help keep the diff tighter?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31428094680
--===============1828966171191452426==--
