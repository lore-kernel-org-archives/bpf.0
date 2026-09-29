Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458B52CCC4;
	Tue, 29 Sep 2026 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689735; cv=none; b=GDmouxZ2XYEHAWbk4iHJ4ng/HjaTxfm8lVAcQjp78OcXWj4Tl7AdJqsO9fhuIXeFP8WFj/yh0xOBb8JLCW1MhbyMH1v5F44AZ8+GZ19lXHROjpZEZcorfM6tH7WwH2Nqb7gH63qa3Bx9rJD/mnz/ktj609wunos8ON27gu98FlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689735; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VYg5Yp/Jn+jG7rpZwvbEbcPyJ/DsLBtgblnOHLOzQtnx6Nad8XFUCvItui6AMKz4AwgBVedaOXdbPfDOzKj9Hfbx5FTF+/0/Dmhoju1xwD8YWlxKFCWE5dKja5BmaQAsPHq6k9U8Bv6CnCU1SrtybNFunB7GeALltznu0gUBDSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeENhm71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeENhm71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC8B1F000FF;
	Tue, 29 Sep 2026 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790689733;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TeENhm71871PnIfP2uUj5yUsaPzH8jjq0toNI7J1HWea0p/PX5pnnf4AQi7bwpqpT
	 VuH59Vl6QL0PVVpzfNfgbUmo3C0NX1ocvPwYxheMNY2Wy4wOFyUJr+tw1QfJsIWCMM
	 /cLg/9zOP+JJ3TDDSmPTHxgzP6RsrlN0DulUXpw3tzVjVEiZwHFhrsZA7c+AzuQOtq
	 q9uWJkgpTVX4bC6vYQ+XHRVrlFFfLUZ0eQRsg/DBoBQcYnRx8sOXGengrBwY64mFGQ
	 GCroh4xMccp9iMufU0ebQJGJvuK9pRuIvtLLWepHFXknUNFsbahJn9KO+KAb3hpL1Z
	 q89x73rBxYK1Q==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Toke Hoiland-Jorgensen <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: 
 Re: [PATCH net v4] net: mvneta: clear XDP pfmemalloc flag between frames
Date: Tue, 29 Sep 2026 13:48:52 +0000
Message-ID: <179068973211.31693.16960645398477065605@kernel.org>
In-Reply-To: 
 <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
References: 
 <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
