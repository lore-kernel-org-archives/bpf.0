Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E453A4F30
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644939; cv=none; b=uaSGwT4HIk1GmM67NJQ6DQeI57tKq895ftiDcG8rTnuNeN+29DaXtfosH7xqPFk22Ixgi/5sV02zWea+Mfxn8ZkIhDHHBIIOzpRUm4ycXfNP5ek4o+RiYJUrHXi3ZjCdehp4HMOq78uwJEaydDnSoYTWMByDa/7mU12cOnQ+9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644939; c=relaxed/simple;
	bh=H0P1lScVtFSMySsNOqFf/6qMKHyoD1CpaabjlkW2qvw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=UT9WXLZ2RGkB2OYrj2Q5EhHAcRQNch7oPVftWKlkC3nlSCyPOHiygHLiHD1sF4QUkPHIZ5TfEnGGcvgQ5Ui6Ui24iIi+5NT8hUPrsjpxRPFYJCK5OCrjsPryfFAE0aqCk4iK55Ihn0RoYuQvNvIFpNP2cs69YLO9g4jA0Ps4wWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU/gFZL/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU/gFZL/"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso172947a12.2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791644937; x=1792249737; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EqH0KjkRiFwhrTqfoRFXIO2xXhT9bjtUTDJStvgxeGo=;
        b=MU/gFZL/X1maFjFLMeW4UGebDGCe6XTK30txt/nfOxCfMY0n/Xx+HFOwP2I4OBRLzo
         OqB4M31zSQrmdE22JI6xUWU/88zXReYE/Q1T1CYNJOrnpn0LeliCjETri1TvXpgqKP5q
         9oPw0wjrHHuTknvJKoCvqEgnnVJnMSqDpSKqxureluWntOyEwXD1l2xuzHjK7OYzwBC1
         PAy9jcLtuUq1sMM4cOOuSNusTcaV08bB0dJRWbbSLYOVkZhWLxflc2XtN00n+xe2lmak
         pJoK+Nw9RW06uppQOat55DK1opivY3pQIPKlG4pROVEAzzxrorm2PeVro+Kp9sAr7DEt
         fy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791644937; x=1792249737;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EqH0KjkRiFwhrTqfoRFXIO2xXhT9bjtUTDJStvgxeGo=;
        b=v2+6KXLwYjJ7LAHxLOL/WW6PTEH7fGmr8B4utiXvCTb8qOxpFEdM4xBIPpdvgjNOxt
         0rk2rrcC8FjJFpC4uOomR0U3mUenkv7oW8m1CLlH336gixbupA7GTCzczkNGf4zw26aJ
         kUaBSkoUWvVB489o3buJxUztbXQlGBuCkHj8N58iuPZI9SFQSHg51oAZeygO+msDvmLV
         HpcadsTsNsOsBOnMMDIL5bd18XrG7QojC9QOimS7x6+eF0ZMSkhD/wK7wI8/A22NQCbs
         JgqyIbsPLYvg9AyyjCZIWyTAuXeWzCEsK1MTdRzE7W1wfx6dGYS8ZktZnwp7gUXrlkVX
         kQZQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5gpvo94oY/aQhTRD9N82oZv07SozwZdvF5r23MwSpOJwJYAvkMWYYAR5XVnyWxObsejo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwJBiBOvRxRSAGfF7QcwagrCSNTwiUbxNqqQfjT4mDrZN+9Vtp
	MxHytUP532kzwggsH2kj5VbCs6I7OlcXzAelX0palopOJuTXZb9TNMjNYUDcS+ERq78=
X-Gm-Gg: AYBFou2C7DdX6MY36BTvDSveGOv16FP4W/jkiPgSxlKtUx8R5YdRpt2xdVpIr/Xi+n9
	7H/FWBGOw7DEh2LqZxDOm+icZvk8UeXoAf6Iroty5VZpR84t6/DTTa9ZsZE/pJt5HuYet22tTfE
	3u9t6EQZS0C9Odwl2uCXNsYzUbYs7aKHH6Tn4TQAhbRr2R/sQlSqjcDJ5zWgn+Qiey3MQWBe/qI
	XGe1ntqX/iXaB/SZ/OiNFVo4hxVi7MFTMmKlxqqr9+IHokjgGa65Sod1It94Tt9axd5ZlAHTDAM
	UmdUhIyY7g99Y5B6vZiEQ82/TMvbK/GabwQKjMX1xgLJleFsYgNyXqA5GGOu8DsCMgGUNFMsQpz
	H69iDe7fCv+jY20/XzCXIkoW7d96bvRFdUme2Kz2mr+o9jN4csN6Alq03elUBJw8yRjUcyH1Ddt
	rmvDQg+nrZ3Rhb8HxSFuD1I8/v2u331HmxF1lAyLXehdjMyxjIdUxPMzIVVx5uJPzJ9cqgHPOP/
	eSwajUS2OeI0vHjuqSGaHaoE5RHorxooLdRNWRNpe2JHuJI6tW5tTP7m+N4NQ/mxkCKYCcag32y
	oLY=
X-Received: by 2002:a17:90a:510:b0:3ab:6ac7:64a with SMTP id 98e67ed59e1d1-3ab6ac70b98mr1638690a91.34.1791644936933;
        Sat, 10 Oct 2026 08:08:56 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3781d581sm8738413a91.1.2026.10.10.08.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 08:08:56 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 15:08:55 +0000
Message-Id: <DM194GWC0XHZ.10Q1AUS5TQYNO@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v10 09/24] bpf: Refuse a landing pad that does
 not resume
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261009041534.27944-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev> <20261009041534.27944-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

# CARRIED OVER from the unsent v9 draft (leftover of your v8 09 mail). Delete this line, or the file if you dropped it on purpose.
On Thu, Oct 08, 2026 at 09:15 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> +		if (unlikely(env->cleanup_info_cnt)) {
> +			err = bpf_exc_check_insn(env, insn);
> +			if (error_recoverable_with_nospec(err) && state->speculative) {
> +				insn_aux->nospec = true;
> +				goto process_bpf_exit;
> +			}
> +			if (err)
> +				return err;
> +		}
> +
>  		if (bpf_is_prune_point(env, env->insn_idx)) {

since you're going to respin consider the following feedback:

The special case for speculative paths is still here.
in_pad is compared in func_states_equal() now, so there is no need
to check before pruning.
Call bpf_exc_check_insn() from do_check_insn() ?
error_recoverable_with_nospec() after it does the same thing,
and the error will be printed after the insn instead of before it.
