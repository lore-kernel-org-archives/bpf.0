Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756512;
	b=OJzfPp32abcI//HKqkpASpmxJzjKr1QM/iH7e1txupvNmy8X/ZrfHSrt7V/xQqteqEAa
	 oEtDvF95wAo0pDn2WMAIyYK6vIwXazfYXdsCF19nFhVZQzNg8asMTDj+HJbi217oG3cu2
	 Gd7inoLGjqSYLwzK+1HNClqWt1swjZtmZk5OjY43hiTN8TRXIt3gOYkEeHwulQWo9umAi
	 6pIBfrKDtYgj2a4P1PPVRJy1QYc5cNOs3cPRHKDeoiHNKyHOr2n2q7NVMn2kNqJFp8AUB
	 uLJqSISUbeNgUCM621rG8n3tp/OeIs8Zr/4PAIJX+qRMilpZSeyryyOs2YwCFx+pAkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756512;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=SoP8Bse4OlNySerJkzY9+iacRNqIuoKa0s/LS7tQjZ1nh62qsvhefBRvgz1RrBSQBHTL
	 raPtrnpPj4+EEQ+IgUz8mK8RqUErHI3i2/Qn+5x+b0xD0W0Fvtq+wvuOSf46PDDpOIj1m
	 F15dpbEFH2EbIIr1nW9/iOQOK746il7mKDc4U0AJUwazxClbjYJbOzA2TY9f9Yzock+32
	 JV9zYtrHwnHqOjaAa39CoHVqmJPGZflFbd+fX7YcH6WR0FOpjg7siJbAOWEkcS69sjj9K
	 2t5MFjyKQ9gDGGIZLpE7BMyRdkwSgsMPMA3Dy6BSnT5JXX1l9PL6OGecO4j9v/8zxXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CryTOao2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F7606A31A;
	Sun, 15 Nov 2026 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CryTOao2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0E41F000C4;
	Sun, 15 Nov 2026 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756512;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CryTOao2uPKoxH+tDiiogYd8Zy2jqY3v4uLHLyPj2c5UW19nSGoj6devW/G5fq4oK
	 3FFMkKpnQ9WY5Pg/0St9elXjq4VoDio3X/b8AmralKxOhuue83v6ej4txyWtPHgjJe
	 dv0J0+EegfiAshun1LPID6+Os411TM44+H9MrzcsJ3TR1mD6zhpsrdF7UdMRb6nPA0
	 hbf8+tWcT0C7vqZTGft3UgjOjegFXRB/uoKpATvktJc1nZqveBPxVAqEKs59vAXxqq
	 eZ0tCpEcSGeR28YdauM5jNWvvb/XWCrs5DchCEnu2LrIvZJpULyCNGVw9A843tzFSW
	 9Y632Du1Ir4tg==
From: netdev-bot+sinfo@kernel.org
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, Linux kernel audit <audit@example.invalid>
Subject: 
 Re: [PATCH v1] net: sock_reuseport: check program type on the migration path
Date: Sun, 15 Nov 2026 15:28:30 +0000
Message-ID: <179475651094.2168702.1367450794308731343@kernel.org>
In-Reply-To: <20261115152408.48205-1-shlomojune6@gmail.com>
References: <20261115152408.48205-1-shlomojune6@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
