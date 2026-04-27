Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3C3EDAA5;
	Mon, 27 Apr 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315421; cv=none; b=AM36/Pi3YkMs7FPX+EZmJe0uYDdny39ipSYlti6uNHYbf1D2XUq/WNPvmxd8q0sqkZC2Tv7Qsg08ODsJVaZ34d3FJpXnNecTYPli9Qn2INHe6A7BTOsV6SdH/aMK8tJyjEelbXS5AqjHQl2dsDK07y7H9sxrhKqwKqM5HcRd4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315421; c=relaxed/simple;
	bh=JikltZZPT3apAsXSWroX2qLzn8xuLeJlyTnDDx15KyQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JbL/sAFz5OYf/J0dMHFXAbPvsMfyG7AVv76k6FoY1EVfQdlJUlCMJ1JctHtz5zEi2wAL5uBoA6gKjHugcL8oderMPbkV6hRTtW0b3ZJGF9apl+xxiYcARd+gQq+bO3QC5mEvyIvbOpI9XYV1w/CQv8Cae6aSDNtpoLz6F2mhMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inuiZxx5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inuiZxx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE5EC19425;
	Mon, 27 Apr 2026 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777315421;
	bh=JikltZZPT3apAsXSWroX2qLzn8xuLeJlyTnDDx15KyQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=inuiZxx58C2RGon0AOgCPHBX9jVdGhHf2TofgAOBHC49e9Idf2HzekZ1fa6ukqa7X
	 lHnbsy2xTtmgIC7dB4noAePVuf6ZRWGohKkUjNliwy1BFuYzQGipii3Qr0F0RFlx2m
	 kNAfubPWgI7yPs1xQJqJspfteBhLxXi2IXgxavGXP2/Oag9Jdobb6rJ0WiTSFR+2Lk
	 +c+g1bKb5FZRozm1/wFvQlUN1+VP/G0WsxZNE3q2FFgvsiNRt7c7xwhDV0Dy2TxxN4
	 YfXWvmdiHkNi9uKHLb4UJ3ZWkmCUhJyLKQ6BR5s//Ub0Wa5FGI+JYppAQM2MLQMjCA
	 h3E5XwO7p65ag==
Content-Type: multipart/mixed; boundary="===============8095452344376425492=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf44910330f919336457c4196379b221c8e7dcbd6c569cc9ed3c1a98d962155c@mail.kernel.org>
In-Reply-To: <20260427165906.84420-3-kaitao.cheng@linux.dev>
References: <20260427165906.84420-3-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v10 2/8] bpf: clear list node owner and unlink before drop
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Apr 2026 18:43:40 +0000 (UTC)

--===============8095452344376425492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit e4bda22d1a0e4a2ede811c0a776c6aba8b315b5a
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

bpf: clear list node owner and unlink before drop

When draining a BPF list_head, this commit ensures each node's owner
pointer is cleared while holding the spinlock and delinks each node before
calling __bpf_obj_drop_impl() to prevent invalid next node references.

This commit appears to fix a bug but is missing a Fixes: tag. The issue
being addressed traces back to the introduction of bpf_list_head support in
map values. Should this commit include:

Fixes: f0c5941ff5b2 ("bpf: Support bpf_list_head in map values")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25009536772
--===============8095452344376425492==--
