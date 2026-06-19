Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9623546C5;
	Fri, 19 Jun 2026 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852941; cv=none; b=MgunTcYA2hCeEBFzsq0Q02qAqX/pJaDbEtIGuENpMxaDUfLjrJoGw3zGKysjzT5gR6JI7spK2dFSzmIjsazKmZznX4YO4iJ6DtPetzvJMS2RIXtM0LK9JXxxEx7L4yJAPT0CHN0nFSB/INk/7POK1hjzwL5SbvTkCyBiLwb2FM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852941; c=relaxed/simple;
	bh=Tiso43pDMy23Il4Q3L9MYRi/ohAadXxDqKPj23OKa38=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QTeFQ/4/86fTFGE3DaGCoWv8Y7vja7XP/7CqVCSpsrke1rUrH+yV2kOxPAzpQdHXf0Y0HsRtV/+a2ZQ3VgsQQtgBIE7MVL4dc1ncEUvoGjzjyy/D7a3zxOenS1cbqmHLLH83bSB202oDlL6U31v+I99zZ/MiOWKeuITOAtCYLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ4Vn1VL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ4Vn1VL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E85C1F000E9;
	Fri, 19 Jun 2026 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781852939;
	bh=5WrPA1KpRetg2BPKOpisB4uo6P3OEkWjhbEdh0thGZQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CQ4Vn1VL8RscqXEuv1NxcGQshEZZTA2S7Vuo8i4BhrPNusZk6SyQTYA70qCi4Qs9Z
	 z5rYKO1HEoa2vDFWvfrZFV+NhxjoHV5QNeLQ1AXyS8MKFCJqFFW4bp4OCgm1LVHs57
	 t3V5g1DpEX1munMMvEMJA+Y7h7S7ZzoayVA5apTaGxjb+JxbZXMfUtTySb39j9ThyM
	 7JNBw95ZoIEwJLLQ024TG2Dkw2TNCb7NmexDNJtMVGF8euhO8QR20Yeq0i4AA7ixhS
	 5SuqH61Wj8aYXRMbOUijrZlKwqftkY5AAt2fxiP7C9K4jyUH/62HUfiM5Mv13/uPk5
	 0Q8aAkkU/gm2A==
Content-Type: multipart/mixed; boundary="===============1744918091706664894=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <09e6a462b410be0756bf7c80ff66c27874ce0f3582e548f12625bd2794b95bc4@mail.kernel.org>
In-Reply-To: <20260619062959.3277612-2-rhkrqnwk98@gmail.com>
References: <20260619062959.3277612-2-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf v4 1/3] selftests/bpf: don't modify the skb in the strparser parser prog
From: bot+bpf-ci@kernel.org
To: rhkrqnwk98@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,kuba@kernel.org,edumazet@google.com,pabeni@redhat.com,kuniyu@google.com,willemb@google.com,shuah@kernel.org
Cc: jolsa@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,horms@kernel.org,bobbyeshleman@gmail.com,jiayuan.chen@linux.dev,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 07:08:59 +0000 (UTC)

--===============1744918091706664894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: don't modify the skb in the strparser parser prog
>
>     sockmap_parse_prog.c is attached as an SK_SKB stream parser and modifies
>     the skb. It calls bpf_skb_pull_data() and writes a byte into the packet.
>     A stream parser runs on strparser's message head and must not modify it.
>     A resize frees the frag_list segments strparser still tracks, leading to
>     a use-after-free.
>
>     Make the parser read-only. It only needs to return the message length,
>     which keeps it attaching once packet-modifying parsers are rejected.
>
>     Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>     Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This removes a use-after-free where bpf_skb_pull_data(skb, 10) resizes and
frees the frag_list segments that strparser still tracks for the message
head.  The buggy bpf_skb_pull_data(skb, 10) call and the packet write being
removed here were added by commit 82a8616889d5 ("bpf: add map tests for
BPF_PROG_TYPE_SK_MSG").

Should this carry a Fixes: tag?

  Fixes: 82a8616889d5 ("bpf: add map tests for BPF_PROG_TYPE_SK_MSG")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27809861429
--===============1744918091706664894==--
