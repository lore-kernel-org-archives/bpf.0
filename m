Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830457;
	b=pjBu2dMKvu8yTShsccCEhCFbYDEGQRhy9lGKU2Mutk+bx5FApexNVYFNHGTGVXlSqJSv
	 wb+DDu35pbEuUsoqdCSGsZDpMnqH+NbyM4pakyx3fn5DuG+o34+uHMTwENa3ASTsLY8T2
	 IkBlXka8QXtszFyuazK5Hgkem7NMLdhx65srP+59n6w0/JHTzS4ocY8g3L0NX3gnq1yVa
	 vG41B0gtubOkpiz5SNXhh99JRO5LtheCpY0s8DE0oxA8F7RVaqASU4jauwVB0hfisbGPT
	 V5d+pEgPzxsARy8N9SBdWH7Pfzf5gXBO637P63FEmtOouXNP5+uhV30AkGkpbU53JSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
	b=NuuCQowZ5ANwF9GUNVUKeypH9k8mtFHLQYF1K97F8lA+0qm1gMuj3g1KgdgGAYq6jwTk
	 yTTpuyNsTtZrdnbIRbAPnan5xNaoYvH33WZbCd1kNRAdLsWIi00WsPp++8H6jiDuZyM1E
	 k+e+jx7HU+9X0uS63c06jYnIP2A/0ZTOMOVc8uzAyjQVMHe/vUJIEI+B7zVUxc/VXZWko
	 kR7oCKHwGJhruyw9Buzoz5v4W3KjdQG5e2XSp4E0X2OvSwhn83tEhxYeVynx6nvTdhTPw
	 suMnhUEbzs44cfm46jOW7V9HI/TR1Qc+dGUVNzkKtbP87FUg0YZJC3BXfswYG4mC3zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O4rHL3AM;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE8606A331
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 12:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BE8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O4rHL3AM
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-492e3189fc9so2149969f8f.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 04:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794830455; x=1795435255; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=O4rHL3AM8g7HMj7xZzkNnKWsQ68P7OhGhMaTci2p92KRiCQKBRod6d2IiBWvipb+DC
         vxIULYuCXp15OPRCoakat7UXJvZIlTm3l608ZOpeQ2tSQXP8F1JduWNlJvmJluBhwx82
         /zjz5RQKsdngqWq2MmIuxSHyh06B4MAfnWmvKvQxetAbGOpMt4tj9yv1/rUEGuXhF3Op
         l1j81S/wHFyKHwmHIqKvzrYEnY13ONP2ciqmD/iT3Hmn84+4ykJqyBiqChsToNXVzSp+
         o+ANBoTZBCPfy4AMYnFAKcCDqm4IN6I9woJSAZjp0OJbMp9884FpNNs3o+ebUrN8UDGH
         OZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830455; x=1795435255;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=fkBVwhOhJmY4/w84i27sjTzpC2DX6YpcMZPZPspMMqP4D8I5UxexJCaGQphO0MbmDB
         rNq1xaTPB8Wrl+Uw2Q1r9cVowzAScQg+Sv0evNwdTWjesKoKAtdlZcvzU7S2Noc9drSp
         e0AHp3nXKnoyYRUEnPWYL275uLQjwSms5A4/hZZ/vT4ucjP2bTzvXnklJejvMCSQ+YaE
         alFZYMNvMCuR/wQo8mQxdiBLmzqU8JlYchmerpMb7BBrdOHdFaimIgjuam+JLAVy9si6
         5Gjvlr2E9muM0wjZ7XnT3eKyozYZ0exfRcITgmE7/oYb8xwu33YsGl7lEzsyjegsbu3L
         MyLA==
X-Forwarded-Encrypted: i=1; AL+hErHEZOchoOZvO0AwctC3ijH2eplqDQ43QKCd4+cgis5yTsinOZE0ThJ7pPhmv0sA1v2TYSw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/zf8N6Wsm68xeNpaGdxsWwlmV0jMqkZlde8mFrCAtEBk8dLdl
	WHFM8KF5U+FCyA8lrWFseV2i7IcOrzfnP6ez6kaAxKiuujXNZzdo6fCTjuezoSqoYTYN9AA+mVF
	UljGZ5Xy6jBZxC+fyvA==
X-Received: from wrso13.prod.google.com ([2002:a5d:474d:0:b0:493:3d97:6e88])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e007:0:20b0:48e:3697:708d with SMTP id ffacd0b85a97d-49c70ed8e41mr16698595f8f.12.1794830455230;
 Mon, 16 Nov 2026 04:00:55 -0800 (PST)
Date: Mon, 16 Nov 2026 12:00:53 +0000
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116120053.371591-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2026 at 12:04:45PM +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
