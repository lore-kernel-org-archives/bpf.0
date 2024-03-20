Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC94469E0A
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954723; cv=none; b=BGD4lmgfSk53UbaTACEVr22u6lqC0u99yG+Yt+5vsh8gvGfWtm/oUUb+duyHixeYOMa2O6eY9KYnMTvD+K3wpmqqujVlioEBb5UIzcl/RncT+c0AIPqPJEkx9ImJz9ijpQedAselUC/LhRePKCx3lVB/iv/rTXKoDHOBlf8+Djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954723; c=relaxed/simple;
	bh=AYnRQ/9K6tKpJLlppW5kiPqZz51J5Knn74KrQUDbO3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvHxgvUy42cxrJ6d9V4W4Q+5x7wWV4SvkGo+H5A8XlLmOh5uLpKo/Yqt27AsgfH8iGIo+Ok4B4JgoLC3Xsaq/Dut3jHijW7IdUE9drK4Zvbnl812pbFb0gZMK1eacAAVmge8pVF4eGi3WiZyYxEtnu8ZgOLEeCk2NBL7KYg6iSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzPGFZS8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzPGFZS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB91CC433C7;
	Wed, 20 Mar 2024 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954722;
	bh=AYnRQ/9K6tKpJLlppW5kiPqZz51J5Knn74KrQUDbO3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rzPGFZS8aJZmiU8JW9GjxoTBVm7AYd3npvhtcQwVKSH6ej3StEQjw0D5rxSS3zDO+
	 EaVRD2lAsyPUUshLQvayHQK2kZnsoBWbEykvstesLrreuGh753vysaOZa8ExQZRsFk
	 ZSVeydMdXevoDrxet8V2yHbK7XBNqm+az4wtuBWFTcE4rDDUfhkQyoHqPMo4xvJe/G
	 dtspdGs+Y0oDnTm43yNMI2TA2j9insFc7+k5oEknITaambIkl/A1Xbp8Tb88wRQphH
	 0tbT9KyAzx6JE7Y2jbxQ+EmB/PBEXV56Fwa8QLpq4b3H6s2wNE4hfmzdp3099RBhT2
	 Cj8EpyJ+aIKKQ==
Message-ID: <f556aa55-c20a-407b-abfa-9eb472af1e1e@kernel.org>
Date: Wed, 20 Mar 2024 17:11:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 4/6] bpftool: Add link dump support for
 BPF_LINK_TYPE_SK_{MSG,SKB}
Content-Language: en-GB
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki
 <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240319175401.2940148-1-yonghong.song@linux.dev>
 <20240319175422.2942069-1-yonghong.song@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
In-Reply-To: <20240319175422.2942069-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-19 17:54 UTC+0000 ~ Yonghong Song <yonghong.song@linux.dev>
> An example output looks like:
>   $ bpftool link
>     1776: sk_skb  prog 49730
>             map_id 0  attach_type sk_skb_verdict
>             pids test_progs(8424)
>     1777: sk_skb  prog 49755
>             map_id 0  attach_type sk_skb_stream_verdict
>             pids test_progs(8424)
>     1778: sk_msg  prog 49770
>             map_id 8208  attach_type sk_msg_verdict
>             pids test_progs(8424)
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!
