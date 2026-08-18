Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FC284896
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787030428; cv=none; b=YEw0m3hoPzVjAeAkLJ7mUZB3d+Zj8dZeyldj6MM9fZtNR4mVe8tUu1a8CDEX0NTS3TV7dZ33nQf8pNsM2JpolPNJrgPJ2HiQTRZ2qrTEfRLE0uDKfaEIXwJ9ZxNyy8oUdPKVh34NvvH+uIbQ5TIMsixrnBu5OqQtx69Yc2hKVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787030428; c=relaxed/simple;
	bh=H/zOlGcY83fmIIgH5EXSWiy0LGwiarK4zHNCO9l+iUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwUvXM045mV9l3zuzUbKO2c267rTEZkmFlP/wJ7B4QXRQjB33Y1+VYCaDu236xjLVgWhomQj0NuLfuNnU4thysbdZ34mS5KPRVAAHMKl+YMaELymJmGSDP6DoYdwYhDu1Iqkbqyo4o4eBMOJO9dTTJwwRO3x3euHXDT6lWwIbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDUk/LaN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDUk/LaN"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84874b52eabso5635767b3a.0
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 22:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787030427; x=1787635227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guhfkRusufvBWD8H2or6jNYjgUQNUVh/3Ni9l2mmIoM=;
        b=lDUk/LaNP85ZQHPwh3yhZnIyAIK2qwpQDuiwHUi6pPpUBJrI8jlKHZ61Wn1avakq5Y
         syXI/33gY0uPb12SuAQF/Beu7WG3aUUkVFgpdJJJIgiDjAA2J4t4y8RuepBl4jGXUBY/
         FFNbtjzJG0QYl7I6Az9FjsxQ9VvzXm2XynpnM1x/GX9gsvd9ADPSdQ85NSRWXQefCDJ+
         HhKHjuMdiB3g0In4BzzZZeCgauNYkpsSzX6zK7TV47r+do3uxDrG3CoKOa7UjNircvbM
         Iim8bLeG1lIORaNMcxdfy5FXrk5UV1No6t+oJnvhIxl5YixyZtlVXQbL4ZRBU3bhI0Nm
         Iurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787030427; x=1787635227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=guhfkRusufvBWD8H2or6jNYjgUQNUVh/3Ni9l2mmIoM=;
        b=ks6Uoxhg/Hc2v4g74G8sElSabZCFSJXrQRonua3FJquA0O0vgIG41jwHudQBatk/zC
         BS5o5IFzSTVgvmUV1HVeY8byBgJfVWG1JK/+/SMvE41DB3qSUkN5NQAn85wyFKp7p1U+
         LZ1xNYkRzUE+v4rNS36rvwljMfS3EfiY5P6/fukio+2oMSFHntchpg/7Ulzpo9ICLddi
         Vo1k7OhoYioagNJ0F9yxkQe4UNVO77NW/VE10jgESqlM+c25/XdvV4vResmH+kbjM7Kl
         MbDDqKdmrPLJWghHg+Qm+MEykoJJ3zgQ/fcpyLl3TpctDmHSyw8e6K7D/oCsjKNbYEU6
         DiRA==
X-Forwarded-Encrypted: i=1; AHgh+RpdNLRFBuiA+80Bc9hFZTFZ5r1sMflCR1TpC7UBrhqjtGXfRYxnXVR5DU+sb23j8nY/lU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkMF+AUOd1pBh8csh+z28GnA63yKblgK7ziEzqGOia1oxwNVg
	5oKHqJyjk0MjKtya7Zr5ctj4Vn3RtNm7e7J/dpzv9VUo2ViQIKnAVEk0
X-Gm-Gg: AR+sD1293nKY3bTRL9Li8kprJqEPIQzjINmIk8Zen4tLkWl0BuOV5Qx+96a5JOfnaj3
	MKAMI9TtHwtJN/46WHZ7UnulBoB+ENf4i5J6oAB1IByfLN77kZ9QlJCBZn7CNftV5Up64graDKF
	WlaQ2b3LYF5ANXEMFRl4nEndCA9xagMMwLen2qmPrz0R7PYU2pGIO92wKRt/n020aR59lWQ+amh
	m+MjS32onNgmiPXnU7r3ZYN1x54cjZ7jwpvOfiY1s/vRWmKfBzw4zK9POn+CI2r9gzAbK6SQx5z
	/Nkb+gdNhdDYOwtyqcH3ld/vRO3VFju1YJloBqr5wNNokHxao2hpnHfOxz6d01/x1xkQtaQgm2e
	xh1CzLVAk0xYcRwh97NXbw7+HyKjyh/H3yXuzzOGsbmSAVLvNbQG9REI8DwO7q53szz4Pc5VIkP
	yuSNqhv17TX2QP8zUDjFqKHTkeiZVP4R+M6AUA/Z0q8PbxFENmswLUTIJ3mSMtsijY4yKtTqNpf
	Q==
X-Received: by 2002:a05:6a00:4ac3:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-84fde001affmr34125452b3a.13.1787030427076;
        Mon, 17 Aug 2026 22:20:27 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6ff0e3csm1046621b3a.60.2026.08.17.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:20:26 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Hagen Paul Pfeifer <hagen@jauu.net>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/secretmem: properly account locked pages
Date: Tue, 18 Aug 2026 14:20:06 +0900
Message-ID: <20260818052006.2387242-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
References: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the patch.

I tested this v1 on its stated base with an x86_64 KASAN kernel. The supplied
selftest passed 6/6 in three boots. Additional fork/unmap and inherited-VMA
mremap tests also passed.

One question: the inode stores the creator's user_struct, but the fault path
uses the current task's RLIMIT_MEMLOCK.

  secretmem_init_inode_priv():
    state->user = get_uid(current_user());
  __secretmem_account_pages():
    page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;

With A limited to one page and B to four, A created the fd and passed it to B.
B faulted four pages, after which A got SIGBUS faulting one page on a new fd:

  CROSS_PRINCIPAL receiver_pages=4 creator_fresh_page=0

This seems to charge A's locked_vm using B's limit. Is that intended?

Thanks,
Daehyeon
