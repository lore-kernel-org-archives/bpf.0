Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DFD534443
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120603; cv=none; b=CVNktGYsByFGtSP+ZWyDqCInD72by9RH5/nd4okZH6t9IAgj6K5iI6lRErcbBlFbSMGrKh/cuq1S4+YChlbDUn+1x/8YMqcl8ox/uu2Su604sonCn8ISkcoacjsVg5Z57RHXxl+AoBMWNrb8+ZPVvKuzZq2jpKZhn8ccES0FNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120603; c=relaxed/simple;
	bh=7VTAV8YqwiwF9z2gcuOH+RzFA2e/x+NnHyou5cfCKtc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HowZZVOgs8fMcF5vM2dukXwgarNb2fXhgtsd6cKGC8+pwT5eAqZj07yPFVBIco/u2WH7l8SG15QwWyxusiE3lrq+khqzmQ0DC3BVPXPXpkF7zwavq+urCxyg0L6r938CmdVGDcsXhj+OUeowpfnhB8NCD5W6gMk/EmzhF57cwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILdg3Xb5; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILdg3Xb5"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32ba4885063so233001eec.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790120598; x=1790725398; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DoMneGs0ZAsT+MpjJcMU4pVBNIS6TyTyTTCrUGmFy3k=;
        b=ILdg3Xb59hq7WhJnsWl6WxpL5m9qSLN5+8AqzEwfeFP2afti5oI/ml1saMuUvLIhbg
         +B9UuYzMJzoggb1j04fPtIZ6deGjL+2/P8ObFDxykKY9hC+Dj5RBlWsTUr19Z4hBYwJ0
         AxOg14mdG0TKwfA9HHhVBGJrlRAmJDLVyq+Yvg6zl3n/57zl+h6oYFDRQlxgu5EqNzFJ
         crWnbxhe6WKjyPMIOOxq6HhaCguT+YLU6kRE+EJq8uJOgTwhEd5THI5hvUHhenYkBNqQ
         YHDWLlQLhDS00nBZGxAsYLuBX7xJvrv3fJeGK/ATyLL3vaasn+m9R+v7J5aH54T1Q/Wh
         j5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790120598; x=1790725398;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DoMneGs0ZAsT+MpjJcMU4pVBNIS6TyTyTTCrUGmFy3k=;
        b=cW6/PHt3bxXIc7GqVu4Mgy2H2ABF78z1g2CvFwMncuSKoz8Fg7TNdgpLxW40Wf1guO
         SvKxzkV7qkfe+lghD56jg1wqxrgI7UwBnNmoN2wdlc7fJn9dRuQKo1ZbLKlNy7DdvP7e
         aCyR5yj8pKWkj3qYksQU6MbxvmYDw6LsteHIje0YERLFzsLK+PDca828kd/N/bYN/fTz
         MTujcaUjAvQ+eDH5gr/+IL6u3796OtZWqUrotRha7jygWSORCafeHb2aQZ2P0Vj2+aAc
         XM+1ioL6oqNr60GAtgmmC7OnOVqDkYyXC9TQOqjtDGgjvgb7J601Eh764QF5pv3GYmFo
         eF2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxaIYZPFAUjWDQVrBRJBgLYHnkhmRlTqUWdV6QgOaOJoHwYsoO23TC3Tyu7pH7Y58pgBQw=@vger.kernel.org
X-Gm-Message-State: AFuF++nFkTM0jtsVta9pYMW2fRVKu57Qg1O+0fkAkNIXTYkq4Xk0v922
	JZzXHiPlKmL0WUdSCR2MCFoXE/jFrpmg3rqQjhVyAZd0YLUgd07UnHmZ
X-Gm-Gg: AYBFou1KTMPYtD1avxM9/pm0aXJiX2EaXudCYY1hibwYMaWDxiwuHx86JBnFRwS2b69
	CKdzddVHUoembl9UDsR5l8Eu+6tlb3fTQJ1Vie8j/Q4ZtJkAdFhrMPREMSOONcwBMuGQv88m7VX
	fAvzUCcUwgohJDP6pH1kXyHLuPaJjD8oLazmk1nj/diFmO2plkfTf9BINnDOeqxJMWJy2r0FHI1
	iMHZf0AVZLNF3Yris8PJxgzjmEuc2HmkJizBTsTSrmQmTaLXlFtF87DBZoxLt0nrpQ27omcuJRE
	h5A6xbtDnXbbbCUDowCwkySJ9kGXQpRPQhn4tWqVt+VRDvdhAYjGDASbGowD0qcGFk1YgBE0iQM
	Jp0BGj7hbhwrH9E4AvAJQhA7hdLugCTexesHWRcj+fRpsVBPW+AQo7EVksh8CV2qUDXu+a0BnA8
	p1c725Cp95xx9AU1FuhlJcX5XP4XoD4N2dKE7tDHo98E90/gpnNVIHSgARNvKG4SskmCXsH5LQL
	B/Z1jfSJcsD27lW3QYs1Ak42LqXzExwMuP/JOexfpm6sYwRJhftqwN+3g==
X-Received: by 2002:a05:7300:560e:b0:33b:c23b:f5a7 with SMTP id 5a478bee46e88-33e8d8d2575mr934090eec.21.1790120597858;
        Tue, 22 Sep 2026 16:43:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f4d5:5623:3480:5143? ([2620:10d:c090:500::7:fbb7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm1431464eec.13.2026.09.22.16.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:43:17 -0700 (PDT)
Message-ID: <70b068fdd15117a681fadb7cec5daa13e36d544c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/20] bpf: Walk the exception unwind in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 16:43:15 -0700
In-Reply-To: <20260921210114.1720196-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210114.1720196-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 14:01 -0700, Yonghong Song wrote:

...

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index aa631bb45f76..076739d4d974 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

...

> @@ -991,6 +994,7 @@ struct bpf_verifier_env {
>  	} cfg;
>  	struct backtrack_state bt;
>  	struct bpf_jmp_history_entry *cur_hist_ent;
> +	u8 unwind_frames; /* scratch: frames the unwind popped to reach the nex=
t insn */

Instead of maintaining this variable across calls to do_check() and
unwind_step(), I think it should be possible to do bpf_push_jmp_history()
in the uwind_step() itself.

>  	/* Per-callsite copy of parent's converged at_stack_in for cross-frame =
fills. */
>  	struct arg_track **callsite_at_stack;
>  	u32 pass_cnt; /* number of times do_check() was called */
> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 680ae191aa3f..2bc08c18ebc8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -18510,9 +18513,108 @@ enum {
>  	INSN_IDX_UPDATED =3D 2,
>  };
> =20
> -static int process_bpf_exit_full(struct bpf_verifier_env *env,
> -				 bool *do_print_state,
> -				 bool exception_exit)
> +static u32 unwind_pop_frame(struct bpf_verifier_env *env)
> +{

This function duplicates the code in prepare_func_exit(),
I'd suggest renaming it to `pop_frame` and calling it from
prepare_func_exit() as well.

> +	struct bpf_verifier_state *state =3D env->cur_state;
> +	struct bpf_func_state *callee =3D state->frame[state->curframe];
> +	u32 callsite =3D callee->callsite;
> +	struct bpf_func_state *caller;
> +
> +	caller =3D state->frame[state->curframe - 1];
> +	account_processed_insns(env, callee, caller);
> +	free_func_state(callee);
> +	state->frame[state->curframe--] =3D NULL;
> +	invalidate_outgoing_stack_args(env, caller);
> +	return callsite;
> +}

...
