Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006B305686;
	Fri, 15 May 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859934; cv=none; b=ldSCtBzSo/A9W1J+xLn41oSkFO9jFjkJNRQFW3F8cs/vx55iRNFyN8HX0IxLVnwyQ+EvxvCzCCGuPjnd1by7An2iljaLf5hQQBzJiKS/OT/N5ylxoLgLGKBGtMo6ZQDiIKa4a61i94g68HqkfqDBLsobmc8WzvJDoKY/k9SMhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859934; c=relaxed/simple;
	bh=/4GLlpJDaba2ZqlHGmRMz4y6aQ8KJ21bj25cclLcadw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWATC//8Zif3QJZTEnWoVvziCxQJ6RuhuvtIEihRNi/jKxcrutuopQRMtVXhVF2lAb2cB/KumLQqIoMgD/FuQGe02GmVG7ZmYAaRnlgTe2Iecqk2WmZvm/v20NE1Dl0A8jYovcPtuePh0sJCXBUFm+7+ax3Dr3U6HAB9rkO1Yr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd45DZ1s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd45DZ1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA80C2BCB7;
	Fri, 15 May 2026 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859934;
	bh=/4GLlpJDaba2ZqlHGmRMz4y6aQ8KJ21bj25cclLcadw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gd45DZ1sHtXYtJkukpUEV577oFSWpOQ5XtjAHqYFy0emvruyIpW0f2pLnwvbYUiEe
	 4ERbfDJ8IRSz9irx4wjnf1zzzRyW8vH37hQDxWQkYhQNeIGSGbmD4BHVMlCAycmL80
	 iuFa+0A5ayItnZV4kwlOkNEeWWyQUxLkjcP9aqQEbs8Rlto6S6Zw+ux0qdqqIeiGgk
	 diPYs0PdoE/xUDSX/bGOQ+d6MnFQd05PzLeBWId4MufIDc/DFV/Zvn5Bk5D6MC1jEp
	 MCqYgK1eQC9C1wbwoNWXQqHULFtqB875vVVKfTx/q1OsMwSt6H/AbKTXr1BOceQwxf
	 pD3MYf57NZ7MA==
Date: Fri, 15 May 2026 09:45:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Li Zetao <lizetao1@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io_uring: propagate array_index_nospec opcode into
 req->opcode
Message-ID: <agc_m0rN3MN7ttAY@kbusch-mbp>
References: <20260515145812.1241925-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515145812.1241925-1-michael.bommarito@gmail.com>

On Fri, May 15, 2026 at 10:58:11AM -0400, Michael Bommarito wrote:
> The compiled change is one instruction (a single mov of the clamped
> byte to req->opcode); the cmp/sbb/and clamp triplet is unchanged.
> No functional change: array_index_nospec() is a no-op for opcodes in
> [0, IORING_OP_LAST), and out-of-range opcodes are still rejected at
> the bounds check above this assignment.  

Since the bounds check above already catches an invalid opcode, why does
it need to be re-initialized to the clamped value? Surely it's already
the same value if we've taken this path, no?
