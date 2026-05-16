Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392423ED13B
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951507; cv=none; b=aWiM7X4aGCmtk1IPPGonNX0xAxhnxtG/epyfnhUvhqOvpLgwuyEXT2fQsf7cURB5R9XjbbPReJUX4XZOHTsPsq00BpVUzret/UEeY1fDNilBFyS7PPi0AmiGYUIBHA56h+82+0Cvz0d3sY/LeBLDv+FEKTeXVvTa5ucZ1zmnJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951507; c=relaxed/simple;
	bh=Q2pPSZqC8vdkBq0hahMEFG9zcwk0/UlsWuqtNoprbCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=URKDZbBS0CZ6S/qhbufnDT+fnN6MTZENURl5VK2zycB6XEFQ2FFwSRr3BN4jKRE9AVmkt6cowBPeVbr3RutxoubUh7a9wWhzpUHXB98y5fgUhoscgJDSH1UkP+UnTrlDEyJsgKDKGA5fYed24OiFvVboBrK2MdDUIBLPfFhUsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4tavPly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4tavPly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11F9C19425;
	Sat, 16 May 2026 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778951506;
	bh=Q2pPSZqC8vdkBq0hahMEFG9zcwk0/UlsWuqtNoprbCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=m4tavPlyRhVMdxBapksW7qyLG9t3gwxbGAQAxaMpaQIga+4W+1eTrKABLCtc63Qvs
	 axOdhf1ySYaREVF4d0pCshcKec7M7Cme48cnw4yIMttZ3O8XiMo6f107qzVxP7OJ5M
	 oNVofO8WfwislgVVr1742Ha/rqqYzVCTjrZ6n4/x0RRSkSsqoFmC5iGARLov7Psybz
	 97jM3mzuaqHgwGY0wX77D3JyP2eZC3bUSb7762cB70j3GQNucEeZX+GnJ9ygP1VM3l
	 C7aVWTM+XfkP1goALIwYRBqDWm5ucw3WHuyhtTfrv11KYfmFky0MJHyfVzTr7fS3FZ
	 muhRnfuXd1Dbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, sockmap: keep sk_msg copy state in sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhang Cen" <rollkingzzc@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260516164319.1519418-1-rollkingzzc@gmail.com>
References: <20260516164319.1519418-1-rollkingzzc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 17:11:46 +0000
Message-Id: <20260516171146.C11F9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf_msg_pull_data() leaves stale copy bits for collapsed scatterli=
st elements when they are not overwritten by trailing elements.
--

commit a47d507f1f74e146090ec75c8b70147c2a08cf57
Author: Zhang Cen <rollkingzzc@gmail.com>

bpf, sockmap: keep sk_msg copy state in sync

This patch updates BPF sk_msg helpers to keep the parallel msg->sg.copy
bitmap in sync when scatterlist entries are shifted, split, or compacted.
It preserves the copy bit for split tail entries and clears it whenever a
helper replaces an entry with a freshly allocated private page.

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -2738,6 +2751,8 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg,=
 u32, start,
>  	} while (i !=3D last_sge);
> =20
>  	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
> +	sk_msg_set_elem_copy(msg, first_sge, false);
> +	sk_msg_set_elem_copy(msg, msg->sg.end, false);
> =20
>  	/* To repair sg ring we need to shift entries. If we only
>  	 * had a single entry though we can just replace it and
> @@ -2754,6 +2769,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg,=
 u32, start,
>  	sk_msg_iter_var_next(i);
>  	do {
>  		u32 move_from;
> +		bool move_copy;
> =20
>  		if (i + shift >=3D NR_MSG_FRAG_IDS)
>  			move_from =3D i + shift - NR_MSG_FRAG_IDS;
> @@ -2762,10 +2778,13 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, ms=
g, u32, start,
>  		if (move_from =3D=3D msg->sg.end)
>  			break;

If the collapsed region is at the end of the message (where last_sge =3D=3D
msg->sg.end), will this loop break immediately on the first iteration before
clearing the copy bits for the interior slots (from first_sge + 1 to
last_sge - 1)?

If these vacated slots retain their stale copy bits and are later reused
for newly allocated private memory, could they inherit copy =3D=3D true and
cause sk_msg_compute_data_pointers() to set msg->data =3D NULL, incorrectly
denying the BPF program direct write access?

> +		move_copy =3D sk_msg_elem_is_copy(msg, move_from);
>  		msg->sg.data[i] =3D msg->sg.data[move_from];
> +		sk_msg_set_elem_copy(msg, i, move_copy);
>  		msg->sg.data[move_from].length =3D 0;
>  		msg->sg.data[move_from].page_link =3D 0;
>  		msg->sg.data[move_from].offset =3D 0;
> +		sk_msg_set_elem_copy(msg, move_from, false);
>  		sk_msg_iter_var_next(i);
>  	} while (1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516164319.1519=
418-1-rollkingzzc@gmail.com?part=3D1
