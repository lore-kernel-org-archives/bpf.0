Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6F23BCED;
	Mon, 19 Oct 2026 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398542; cv=none; b=rCZLWQdmWc14diXz6UZrC4QFdITljtznZSL5MdHcTMKEbIslP9r8DHx+qVvHu2kY86Y6n1U00dpjWRGcP+WWfR9l72Wwpi2FXsPrSWeorbxGKw8pguP5ViP0Enb/31jtKr/+aaQD3JrAuoKm0L2fly+I9gMMc2VoxSULlZKkYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398542; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTPOzfxM15yGE5XMRlA+vV51g9dH+iwgrUuGzhi0QUqdNwiobbWRcvarkMt62DyeR6qeKwQvXNqLjQ4mQvsJ4jfklCsP6jFOlerJfPYQFH1Igr37CGyEk0Lp7EkVCZwHYckKWfY3YqNHaHkL7tLdCkWWgvO9HrFS8QYYWpAqHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M93peUZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M93peUZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32071F000C4;
	Mon, 19 Oct 2026 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792398540;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M93peUZTDz0MiseZyb26eSF5OyV0ritNlOZjU47+F/Lul8y7LqafvOYVRh0m2FjRN
	 SttfevRF2uf4kK/pwIOyANSvZ1tqVAwh9vzz0F8fh5wqG5RZY2irZ5kmMNIWgDYSR1
	 VdFWr8QG0OMkVgLdSH00H5e6oA9lgs1UHoU9WoB9bZaf8d/PVKL1OJLwu1x3JpTSXM
	 HhSshGuvqyYkVqJWREY6f0+/RmIJqF5RtXVcCrtFlKkDEvNTn/EFbrgVsEanOXDegn
	 c8pM/raQaEgIsgEu3woSDq+PI9H8Olj/HyoIN/BNQyPsJnfpqa3BxOEhM5A6ieWfJo
	 V0AjAJnNbZUTA==
From: netdev-bot+sinfo@kernel.org
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eric Dumazet <edumazet@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Kicinski <kuba@kernel.org>, Levi Zim <rsworktech@outlook.com>,
 Denis Yarapov <yarapov_d@mcst.ru>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, lvc-project@linuxtesting.org,
 Sashiko <shodan.ai@mcst.ru>
Subject: Re: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
Date: Mon, 19 Oct 2026 08:28:59 +0000
Message-ID: <179239853943.3290.3841022911205774928@kernel.org>
In-Reply-To: <20261019082214.102398-1-dmantipov@yandex.ru>
References: <20261019082214.102398-1-dmantipov@yandex.ru>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
