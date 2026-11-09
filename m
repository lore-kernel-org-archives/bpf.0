Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235663;
	b=JJUqNtlfFQn6cLf6CXKZtaBvaJoyl/bG99NG5nKm0yu+GD66kC72l4Hi/lxLLWsc7nb3
	 jM8N6PYluEODP5CHrxp9zNJ3uAemk9yPRsirJXf3w21qxqO2S7zAOfH9eqKu3XYoFTl6y
	 Vz7Padb1fIbwzJDE6CTFFsxW6oCasbMGf5X/Yskoa0ua7Q4NoMD6K3Q2tmNFyQZBpfHpU
	 lECZI9K8NpGzIgWz0atAPa1kz3tvkMeDrSdOngPcjiskfHY/0IbZpN5I7SlLyMj6P+BfL
	 4yP+C14mXMkimiHuWkauh/54v71C4b6ngGRbIW3Uwe5EzZkbA60sZczgY6+c/TemzLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235663;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=fCejFYKhSDSc4JwMyPtKhqFWSs53cbQeZN5/DcI4hvQ=;
	b=jTTBnaxUfuci3mHNnHv8GxmV1rcYkW43N3cPy61A5K4k1CoSGoz5mDMtDylPNpLeKIWD
	 0u7sNG6Rw199KajR7qIZuAfIimQhOrcHXJKahj39uu3Pf+r57AzRcHWsZoW8z+ekYkzey
	 JEV2NaTAJEqT28UfOrnFOpZ8Z2I/WkF+xwT6IRlly93rVFrvrsbB/Lxqx0gu+ximch9Na
	 /wFcvBLE9OmxWkW+5yB3SiJre+MWNwxt1YZPr7zqTKGeYUN7evRZACvioMnhiWtcEl979
	 FDGTfjWPPuVxaQ/TJryeeRvI/OJXDJjcoGxPO915f0/0u4iRHVmRuB17lmR0eao0MXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap0TkRsF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32255606A338;
	Mon,  9 Nov 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap0TkRsF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1BF1F008A7;
	Mon,  9 Nov 2026 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235662;
	bh=fCejFYKhSDSc4JwMyPtKhqFWSs53cbQeZN5/DcI4hvQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ap0TkRsF0J1sF46OPHxM1LJk2VVMuImp7/uyFuf3noGatBDl4pNMKn674H/A07n1S
	 pWTf4Z9VGhqQIrAPUvVTOKsvUll+sIASdTaakVsZglA+I0vS1LW0HCOf0mHKTGQmgp
	 XlH4OgIXHP0BtGn5SSrPdEwGynT6KNuoNE7+2e7b2zK/IkiI7a6KDMtHk9UQCxSaXF
	 PdOiWrdk/M0mLk17j2t9jTWpo813hOUWhbeUeqfzCFxdjrac/WJDD3URsrsAvyFNNZ
	 ZiZAlNuuqbA9MwJkswgbDh67ytUO4kWwliXn6tg984Kmobk2oSD50kHTbs7PzS54t7
	 A5MV2NGrpCK7g==
Content-Type: multipart/mixed; boundary="===============7308541728086898334=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8a2b570a4d824e7a7acb46464af3318cc99a87ac6b620dc5cb76d9966101fd1d@mail.kernel.org>
In-Reply-To: <20261109140816.5196-5-leon.hwang@linux.dev>
References: <20261109140816.5196-5-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 4/9] bpf: Add log support for cgroup prog link_create
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,kpsingh@kernel.org,matt@bobrowski.net,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 14:47:42 +0000 (UTC)

--===============7308541728086898334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add log support for cgroup prog link_create

TL;DR: Nit only: the new <linux/bpf_verifier.h> include in bpf-cgroup.h may be
unnecessary, since a forward declaration would likely suffice and avoid
pulling it into tcp.h users.

> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/bpf.h>
>  #include <linux/bpf-cgroup-defs.h>
> +#include <linux/bpf_verifier.h>
>  #include <linux/errno.h>
>  #include <linux/jump_label.h>
>  #include <linux/percpu.h>

this isn't a bug, but is the <linux/bpf_verifier.h> include needed here?

bpf.h already forward-declares struct bpf_verifier_log, which is all the
new cgroup_bpf_link_attach() prototype and its stub need, and cgroup.c
already includes bpf_verifier.h for bpf_log().

Since bpf-cgroup.h is included from include/net/tcp.h, would a plain
forward declaration (as done for trace_events.h earlier in this series)
keep the verifier header out of those translation units?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42633880300
--===============7308541728086898334==--
