Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271D41930F;
	Thu,  1 Oct 2026 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790831586; cv=none; b=EE0VUWhJvtE5maLdlUBwmO52wwJymS99uiIUq1ePcj7Xe5xgY2VUqCla6N4ovre+7YEQS7xavRe0EIhyAFcsrLLSU1kvxp0kGPh+Yok93LyRmFJnI1wFqfd6PSE/ik1VmK7mYO11AmJtqgWfGv0o1qcwXr0XbaHHR+bd6Bpbqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790831586; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=niWnRG+uIkqk83RHIEFVAmPay/+c+4AACs1bjgCX01pIeYG9v6+m77UlYAgT+CnzJd95GeW4lz5Z0whS11eDTW021G2LmmpQFg7pXKE/x2E+MlHdgFALA2Aqts2f6vm5Sa8v8QD3pC+FEqt2kBcxB0ASm+r+DvtHMHuuFQ4OLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn4GmnIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn4GmnIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2681C1F000FF;
	Thu,  1 Oct 2026 05:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790831585;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gn4GmnIES3i0jq5CV6Q4y0M8JJYjdW7i9p3Ac4lYMZPrDe8x1TPlJknq5U4PLEDsR
	 pPe64yjbXYGFDJkOKbxe4omhKcdvbPiIDcHrJACeTQ13lenafwAVMorVi7EDm9epm+
	 BXKtQA3H1SOWMV4ZwP6xXrwAoFP03u8siu6XJtiZHr8fT9d/40idFbKNHNX8bUXeRt
	 8PbOEIhqs3n/ZdJU6maQtlh+0/zrrl/toEe9Welz5fJWPEVOnnwIvdvWuvW8/AMIhJ
	 mw951kv/441hMg15KkL7v+YcV6DbvGhf3VbMTlyiSZSSi5iSfT2xD43zlaULnDtzq4
	 r0vv2qD4fSa8g==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xsk: freeze deferred pool teardown without blocking
 unregister
Date: Thu, 01 Oct 2026 05:13:03 +0000
Message-ID: <179083158364.31693.4968269038838216649@kernel.org>
In-Reply-To: <20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com>
References: <20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
