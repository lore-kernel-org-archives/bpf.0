Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45F2931E5
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154758; cv=none; b=onFzgZ1lWR0OcibSNVdwbOShaUSAwDlXyB//RZOt3eNS+FgjgEHTeZ96c/euysgwqHUh7FF9xX/Cd99OwFFH8OUkLO36R43O4LPvZdPCa9fZp7yAdo075jYjp/Jp78Kc2loaOQ5fiWRXiy8UN+JdNHb1DoDua/a7Y25O4Fkfacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154758; c=relaxed/simple;
	bh=7TKxPE4UJr9BQbC/5CsF3TcwxHcN1jmh3NGVXx/XARU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEA5A8n+URvSuA1hZfs0/tDxa/oztlc515jS9ubZ1ytU4SUjC8OL2at921H67vVVcEnJd5WhUe6XTfkzX6E9/M0fo+m7rljqLUTmGyxpwp3PSAAQxqw98poxpEZjVsJ29/x4K2wiaJaxXn8FUGsiohMCDd6V9uXBSl/rjs26eQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPsD/91B; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPsD/91B"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so644315a91.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154757; x=1784759557; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XJNVZGdJ11hT7AjFIS4QPd6SCSd8sHuL/h5Ov1KUBaI=;
        b=TPsD/91Bobbge1JBMjgpHwmtLz1Q6SWMwOLrgPZ2MhzGOYsNvXCGiR0t26YDeJ9P3+
         ET63l2oy/QH2JQFockpYR/qKLM6ryRqiCEttuQjkXTgBcvnshGdq1F79FEBeOXFvo3XP
         +qEDL/G8Y1hloV7GB0+CHplajUgraFCyVtA8wC6XSajUSvuhBXGomFI7sHgXaykAxu62
         ffdDuGmbhE7iR+Rc5XQASX5aW6N1lPkW+tY0GwssxeuKf6R2wEySqFZueoYb94yQeWWb
         Xl+rQIWouB/Xe6VY18hINz6p5vPc7ao8eZx7HMMzszkjd8BH4qQ2iOXuohz/Zh1d2Ciy
         mPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154757; x=1784759557;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJNVZGdJ11hT7AjFIS4QPd6SCSd8sHuL/h5Ov1KUBaI=;
        b=YjWx3bqf0TqOKoIdCoo6vkZdBsys3wkTWBbTQnhPtLGvgYDXp57O0Dc7mI4nBe+GEr
         zQgD57PlaC2365NbedAwRF/Trnc7fS2lohuW9AWP5emmDlppVxqpXIa+ErjkKC1jrESp
         LavXO+YkvujgbaoZmRTne3SA1Heua6v5UxJ23dAEbGCoTDpljd+FX2/q2k/Z7gdFh/pz
         FLcKFKFXT3W1A0EIqxdfjG7CyAHHD4SnaEijggbVsnJ+IXWX42MbqQLu+v7MX5snwvhj
         jp8o/I+sERLkTZez71G9ymLWjjnUKrddTMj8iTFi4qeP7P6iPM9BP4DNFd83L4TQB4Uo
         JovQ==
X-Forwarded-Encrypted: i=1; AHgh+RrawvecfWn0GulS4ce/GnANhTTLNBYMQKwdQ4bg3vgGVNBWdfNLnHgHucq2QofcbbhusQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxysVyUsKS5kZ77OBz227vJrREdpuA6EUHO5JwIx0nE3HCw9oEY
	JFt3TfDTT0HSZRcef9vsFKfb1wYUWZbded+KgWiw3i6KNR5oQOwg0AbgJPnDNqKY
X-Gm-Gg: AfdE7cno7/DczYAa7fyuMdN5izGyKJyEr6ajVI2h0hnANYkoSAOaC89yRIwuS9Au2lP
	VCFUKWLQbpiEv4FYbYV1b+b9sw+uJrMwbO+BG234ZtoO6coINI5U+1Wq05puVIilutPmK5mRmWW
	Sr6PHLqczBV1r2NyAKi1yK9jTwT2fCGTCxVosKZNhHa4TWjuMRwKdVtecAbsnG/4pOiX8zGzKce
	1d68B+4pqKivu2Cutshuia2oRYLsWkTi9JVTfuJGQQJS4ymW8I8Gj5La2z2kJ99UjlTZMZ3PUZ9
	UPvEKMsfh84UuGW9eBkDnqg0UR4V5b+pHn+SuMG2x9o0aGCn9ZVub18nubBAXi5FsgH449Aq6gn
	TS4PiafLahsev0u9fulQ/RJbeZp0UbYv4mnwqwgqzyR97zYuF+sBo4C9JJ/OmOc9ITOKl82DXx5
	2bMazdhFpXXaH1mrtfWok6zK8zM87PKg==
X-Received: by 2002:a17:90b:3cc4:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-38e1add8aeemr6279274a91.7.1784154756652;
        Wed, 15 Jul 2026 15:32:36 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3cf246c0sm27300a91.3.2026.07.15.15.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:32:36 -0700 (PDT)
Message-ID: <4db806f16867c81f04dd0d1dda6e87349c1571ac.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 04/17] bpf: Prune verifier diagnostics when
 switching paths
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 15 Jul 2026 15:32:33 -0700
In-Reply-To: <20260713153910.2556007-5-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
	 <20260713153910.2556007-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 17:38 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d0d399b879e5..648adf3b7aaa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -189,11 +189,15 @@ struct bpf_verifier_stack_elem {
> =C2=A0	 * and after processing instruction 'prev_insn_idx'
> =C2=A0	 */
> =C2=A0	struct bpf_verifier_state st;
> +	/* Only conditional-branch states have a queued diagnostic branch. */
> +	u8 diag_branch_valid : 1;
> +	u8 diag_branch_cond_true : 1;
> =C2=A0	int insn_idx;
> =C2=A0	int prev_insn_idx;
> =C2=A0	struct bpf_verifier_stack_elem *next;
> =C2=A0	/* length of verifier log at the time this state was pushed on sta=
ck */
> =C2=A0	u32 log_pos;
> +	u32 diag_log_pos;
> =C2=A0};

Assuming the bpf_diag_record_branch() is called in do_check():

		if (bpf_is_jmp_point(env, env->insn_idx)) {
			err =3D bpf_push_jmp_history(env, state, 0, 0, 0, 0);
			if (err)
				return err;
			if (prev is jmp) {
                        	if ((err =3D bpf_diag_record_branch()))
                                	return err;
                        }
		}

This patch would be reduced to diag_log_pos management.

...
