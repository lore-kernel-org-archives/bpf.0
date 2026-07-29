Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48912446C1C
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319081; cv=none; b=gjD0LK9wEfSb4Wa9oKoGMeuUugy6aephE9tq6FrhrRuRJwa3PJuNbWm+vM53L/xV0eEb+1lClnhpct2IxDFCtaaRD15z5nQUnPvLw6qCWPdNIOzgzL6cOnboTjsKzcSzSx2YVU+kKs6ZDNg+aaiEuHf94EdRaboT5EUvfDnK9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319081; c=relaxed/simple;
	bh=jc0OcuuSoNo5s5b6ZlMsjyypkNWQwthg28ZKWNKWaMA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=N22JhFABrE38Ry379crUcQSWGGn3ueGEv3TamgQupQTf70d3laDVjeGa7u7B2YGScxBJPR6fdgDFqk+6sEcQwEfKEhoXs9+oKT3Sx7nvUSAFzaSjMw+VB/4iF0XKhEIX4m3fO+2WvXwygqty+BjLyJI3QPoogmnxgPpZ/KpfwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHhAk7CV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHhAk7CV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046831F00A3F;
	Wed, 29 Jul 2026 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785319079;
	bh=GmHyLw8cXGJSKUi+sNddXEk16JwABeEXxYBjLxTKaS8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oHhAk7CVwMUvwPj+vy3wQkmDVy5ft4cAI+2e8TU3l8Z1E5hOUXAm73LwyNfeNajPw
	 LVGloUuei45X1B17h6XUj0vXEdp9Unp1cGGH/Is9Ep91srP+LplZwmLeTba3hKZyTL
	 SiXm0fk8rodjqaSAaG9050pVQDnjlr64LnqDSpaA59KWE/dyO02hH8seEdOVviXyVP
	 4k3JX/C6cxwjFAjW4J8zaEElnMz00aURKdl6lqx7lK/ERGcIPUg5HYCE4jtQPjlRdM
	 wsg3bRe6ryo0V5KL8m1HdQeR54wvl7RJ/nesuW/mBmt9xRgq/PYnDONbgmNTUlqD6O
	 Iu9VqYtOPC6Zg==
Content-Type: multipart/mixed; boundary="===============9035002305128744632=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01ae154752b68a1ae0f49bc501ec05371ac1886ec53e753afaf5ef5af9274fac@mail.kernel.org>
In-Reply-To: <20260729083807.1588544-12-jolsa@kernel.org>
References: <20260729083807.1588544-12-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 11/11] bpf: Clear buf on error in __bpf_get_task_stack
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: sashiko-bot@kernel.org,bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,contact@arnaud-lcm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 09:57:58 +0000 (UTC)

--===============9035002305128744632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Clear buf on error in __bpf_get_task_stack
>
> Both bpf_get_task_stack and bpf_get_task_stack helpers that use
> __bpf_get_task_stack have buf defined as ARG_PTR_TO_UNINIT_MEM
> argument, and we should initialize the buf on every return path.

[ ... ]

The first sentence names the same helper twice, "Both bpf_get_task_stack
and bpf_get_task_stack helpers".

There are two callers of __bpf_get_task_stack() in kernel/bpf/stackmap.c:

    BPF_CALL_4(bpf_get_task_stack, ...)            /* may_fault = false */
    BPF_CALL_4(bpf_get_task_stack_sleepable, ...)  /* may_fault = true */

Should the second name be bpf_get_task_stack_sleepable?

Both of those helpers do declare .arg2_type = ARG_PTR_TO_UNINIT_MEM, so
the rest of the sentence looks right, it just reads as "both x and x" at
the moment.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30437558115
--===============9035002305128744632==--
