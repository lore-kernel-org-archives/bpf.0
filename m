Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819B4B5CD5
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445453; cv=none; b=UA306g3BU+BqYgE8KXY3NwPVT3E5+IH6AhO10QEeVF9AHr7kJnnOOqsuH2opAMZDkqTZClaG3YdXOu57N0owUhBwtvgsvA6x5WKqpCMo0WW7AveECLMRvu9BqurnTkDGYrpoqxR40LSjtEm78u0vBKsaYP48gFqbKmfy0yVoQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445453; c=relaxed/simple;
	bh=BYb172QhBGqZ+8ILLGzQ7qkpvYTVUP/RAktVNWsoJQo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=NR5J8nZkKYp5wTBqIbzkvgA3P26+lQUG5xjjJ/ElmwlIM3XNeJDaBazKwioTVKZObJ3XoStGmsP0VU4lxnitRf5zLOYGsCPC2IDbecKAFhCFWaayh7OOTT/UQD/ukgMZnEJ7WDvG1M/dHNzn1cCqHSWhWS1nIKKwXWdgnRpG7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpyyQZm5; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpyyQZm5"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-483960225ccso601764f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788445437; x=1789050237; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/IoCwLnoguNHd92VH5ak3hPrclc/PbnP0NcTSqJHRPQ=;
        b=dpyyQZm56OSzc/LkHZVC38rsQvPtxVUD2o/CRDZhwetibbBnXp2ZAxdV61Ehz4vI/P
         lQdW3J8hhVD7tQSfqdBGO9iK2GtPnxyuA2Gul1rixJ0ySZ8Lyszkd3pfyJR4Te/2YQfB
         SBr3u0tAZ2gIC8Tks4w+87n3hv6hXBd7TKM7WA277IU6rrB5iHFbdtuirXn0xwwZHohW
         ROQC1ZPInAXP+5+EWRfXhB9fKz/pFiFHlhq+23wkDXS2v+nTumQDFEijtci38c07666X
         yarxT+KwF5a2pD55OUDr6x9DikAi1rhxOluFHMqbSTq0ZZmBQ77m1o/ewnDE3aUF6BG+
         32CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445437; x=1789050237;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/IoCwLnoguNHd92VH5ak3hPrclc/PbnP0NcTSqJHRPQ=;
        b=dcouSHaQGIpS9ktw0wS0w53NQMthLSZ3yxPRacUInsgowpVBjvEpVfFz3lUi2rmENF
         V/CWEdxHNf93Lyu4bkhzLVP2fw993lMRsBClLtVsfGtROqm3QSibW2MBV15ff/mhtsdT
         NYLYkjWNCuNvMyZ/T4wTeX0am9l6q6Tz8BjRgKjjUyjU5hIlsysm3CVFgkcEwtLdS/vW
         aKgTsrVAbl/0hBU2XUazHrAvnLqffvqSAK9Vfet0IQLcEjBGRzmXBQ8Fj6FGYFpcpr+h
         ggc12qxar6d0criizT4tgqMEc/mIVImYrrp+yQptfg8Mfu6KVJNWmSnYgUCpojG7t6LC
         d31A==
X-Forwarded-Encrypted: i=1; AKwUvBwIhuiM8l3V2P7QaOF4Z74LZUA4veSDOwHOUIDvz8kY6qksOORAWmu5a5sPzXK+yzS77/8=@vger.kernel.org
X-Gm-Message-State: AFuF++m/147xDoBdq5uUOm3+WneI0/P06go/txfCCRb5MMBNGjf1mveX
	KruFV/236DqTYm9CQz0Ds7b1xMc3P06cKOrLGdwnV4W1xI+9hCwiIvzx
X-Gm-Gg: AYBFou2BYje0hEDBLZRhNI4ipEjpJHKtBwxkgWD3SoAwFOt3wpv++dJJuZfjdHFi0mV
	Aw4o4Fk1awjaGSk+jbLUdu720HfkbWz/QUsAJ58RNIE1jecfpGPrhbqswjTYxRpzX4nsZBE/PYu
	gTmtviVAnXwDtvi4btY/bzDlCmwH2Yhcg5ljWz06p2yQCGDmdfrPc72JNOXFP2KTEBx8OKf3YbX
	/I0rELzshT3GhG5cmQOpK6rkvYxD4p0QjHNHN3FABGteQmfWYa2aYi/3nc0/1nSHLFw4KhMCUwq
	rwjjjCzjSkFrHi13ci0cPbv37cGAc/NINyL17a9qnpzDe3vfosRLfaXCdHc9Gn8p0bZhKudpQnX
	uuCm72Xhaa0kWSCX1abFFx+/FP1n41KeOry31Vuq8cQycSphqid+ZHSmUT9uI9aboeZlCtddIpH
	hvXYDdfiQwOXfGkCGBy49hqwMuZKQ6+nxrfdd6lQMfixOy59KEbQTQS2BYfesUljrkiQ6+HkhKj
	CW4GLT5TtMzITeAdi6NIUtWbw0+otdQ1tSaoVpk9ZonY4LJf0fe+/ZfUqJGqbPCk6Iphwfc8eLa
	wWTzI0/KAEyI2qkBcm6tFIjRrr8=
X-Received: by 2002:a05:6000:2282:b0:482:e62e:a528 with SMTP id ffacd0b85a97d-48488f0e579mr26609835f8f.12.1788445437197;
        Thu, 03 Sep 2026 07:23:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed37c4sm12369281f8f.21.2026.09.03.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 07:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 16:23:56 +0200
Message-Id: <DL5QZUZ3T8C1.1OAICGO0O42FW@gmail.com>
To: "Utku Erol" <utkuerol71@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <qmo@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: disasm: guard print_bpf_insn against BPF_MEMSX |
 BPF_DW
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260903133434.17860-1-utkuerol71@gmail.com>
In-Reply-To: <20260903133434.17860-1-utkuerol71@gmail.com>

On Thu Sep 3, 2026 at 3:34 PM CEST, Utku Erol wrote:
> print_bpf_insn() renders a BPF_LDX by indexing one of two size tables wit=
h
> BPF_SIZE(insn->code) >> 3. For BPF_MEMSX it uses bpf_ldsx_string[], which
> has only three entries (W/H/B) because a sign-extended doubleword load is
> not a valid instruction. The LDX branch checks only that the mode is
> BPF_MEM or BPF_MEMSX; it never rejects BPF_MEMSX | BPF_DW. For that opcod=
e
> BPF_SIZE(code) >> 3 =3D=3D BPF_DW >> 3 =3D=3D 3, one element past the end=
 of the
> 3-entry array:
>
>   UBSAN: array-index-out-of-bounds: index 3 out of range for 'char *[3]'
>   KASAN: global-out-of-bounds: 8-byte read in print_bpf_insn
>
> The out-of-bounds slot is then dereferenced as %s.
>
> The disassembler is expected to run on unvalidated instructions. Since
> commit b9c5d822f677 ("bpf: Add source and instruction diagnostic context"=
)
> the diagnostics facility disassembles instruction context from
> check_subprogs(), before check_insn_fields() has rejected the opcode, so =
a
> raw BPF_MEMSX | BPF_DW insn reaches print_bpf_insn on the ordinary
> bpf_prog_load() path whenever a verifier log is requested (log_level >=3D=
 1).
>
> Reject the impossible size the same way the branch already rejects an
> unexpected mode, keeping the disassembler total for any opcode.
>
> Fixes: b9c5d822f677 ("bpf: Add source and instruction diagnostic context"=
)
> Signed-off-by: Utku Erol <utkuerol71@gmail.com>
> ---
>  kernel/bpf/disasm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 50b3ca5149a0..70c2b281cfe9 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -299,6 +299,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>  			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
>  			return;
>  		}
> +		if (BPF_MODE(insn->code) =3D=3D BPF_MEMSX && BPF_SIZE(insn->code) =3D=
=3D BPF_DW) {
> +			verbose(cbs->private_data, "BUG_ldsx_%02x", insn->code);
> +			return;
> +		}

Already fixed in https://lore.kernel.org/bpf/20260820022020.3450479-2-memxo=
r@gmail.com.
At the very least, fetch the latest tree before working on fixes.

pw-bot: cr

>  		verbose(cbs->private_data, "(%02x) r%d =3D *(%s *)(r%d %+d)",
>  			insn->code, insn->dst_reg,
>  			BPF_MODE(insn->code) =3D=3D BPF_MEM ?

