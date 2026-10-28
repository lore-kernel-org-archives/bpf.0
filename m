Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153721;
	b=3ZA2IZ6/QOGSQjKuw1adMUZhZlB1Akcz0uVK7OxWzwu/IQFVIgKbxP9LvKXbaRk3qZ47
	 cf2obwLDv+tnsMsJgAOaNloKfWRGyV+ziGh9yYiZhCzMA31b4hg69uGzpNjzmpxjkhvXl
	 sVZ9T0/wAg+ke9EF3yC9oCM4MhN0wu3AfkYoOycsvXDWMPgQkXQOvfKdKRGn0NwfkRr9B
	 SGntED3n2M21FikSBfTW6C6FI1Y+qx+wTGCMmA2s8Vl83qzOHHE85zKHaIhjN7GxqaA9H
	 Np/uHrShjyLomGusVgkDFh8XTisNYM2dIl59xf2IRPG0MtT8f40vgnzGAg78y9BHuGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9DPl79dHc6XuMltSswrZOUSsZxtmP6an99m6H1S4WSM=;
	b=MEb0CGdvUGE24/51IOMKfVvAmWst2rpIJ7pg79AAtj3K0QHZoZpqCwStjEf2d/+RtZlE
	 oqMnQlxPrHL56jciz93rhshHOUq+6sZAsOketwhNvh633q1nWp+9rHQ9il93TKgccO68S
	 GrK8U7wyHSQ0/harCXjYlYw0JZ3Gzf79P90U2QNyp2NyVN7sz6nbL+7WXbFDvyxChDzvw
	 smypXjGY0fuumOk3EGK1m6HElY2ABzNO7ZqGokEiokTP2UDbvdouJZ+g9mXdfC0bO0XG+
	 +u1CzYEawcLC/pNXvI2XQcMLsIQOfB0IOQE/CMsE6At4KVS4uyz9EsJnojNAwEZojLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HqedbEf0;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C3606A324
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C64C3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HqedbEf0
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-4a35de71c45so1619925e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153719; x=1793758519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9DPl79dHc6XuMltSswrZOUSsZxtmP6an99m6H1S4WSM=;
        b=HqedbEf0Ry+E6n4xYAMoNwkTKhuXn2x8DnI2lnM++Kuz16i1q85ukllRXPoGgrqG49
         IoyZ+NCW4yb9cIpWuDntsaJW2u1d9v9uafIY01hynakuY04RWvrQIuWYVLydSqBDBdnk
         vhKCMMhnlTKbmd+ZyPZP9C9zTQaKA3K5bnJ+IdboOK7xF6faH47tuGTRLLadZdLT2HP/
         F8jDTk4e+Ke1PPP7fhqj2Kp3tYFkm+k6y9thntTIoIc5HqlssPRHykhZny6yxJs/rMpc
         /4lWU+xfLiHa7uXKxXpTOjME79q9cfVHkdDssB53LsdHUjCCDk9XMMTNi1BX5HcT+yjL
         MFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153719; x=1793758519;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9DPl79dHc6XuMltSswrZOUSsZxtmP6an99m6H1S4WSM=;
        b=hIl3IB1H4dvnQXFx/v9RqRR7LuwcsCPepZTi0MYBVZBK4v4FE6ERQ/bExM1RAr97HK
         LIDgkqzKh3KVR9VPuemcw+ZZ5GzCQyP4efD+VxjjXkFgagNPXeOURyKfW8NhaHNaf1do
         D4+AWayW2nxemTEFnHTmkcbNCeZ6QDXz4Vs7K94PagO/xUSu4CIo5Na54ixexSrwLWh2
         teHFXeZQGYZo7zg3P8wjHndfaaNess5U/EKuCjzW7jnxl/0dRrWSpYaLBVL612kQ75vW
         Sw1S1P6E77FUdZ2ltd6DAV9bgL+S9e5NdyqsjKCyMiJnOgLY340C+bCSrsh0jX3i37Gv
         hfEw==
X-Gm-Message-State: AFq9FYK7RL05T8EBqKr+gJ3VBtzr5Q25EcEwD8KGB4n/FhBf6Ov9GxNj
	eG27Y6ekDi7bFg2/E5YuSlDOghCgmOP+syuCHXFcwHspZYlbrfHO3YwA
X-Gm-Gg: AYBFou0eCVb7I9ISnxyurya/8wFCqtkqNMshYMO6oIIiqz1VCfh5N/dk8DSdG3+3ZD5
	xdoA8e/HtJoAMDJWe3yhsiRABxtk29OeNtYItgarm5zVg53rGOStGNVfzGSfSEDNnaJ1sEPXkn/
	D1UJGAJu0WySeaqMyGfMSmsa57IQrMcrbG5OlcIc9tyXyqv53UBg2ppZNIBLN3NSu2fUV1JoyQF
	MMNwQ8IbBl+XazsLxRdLFqqMJYUdeqBVFa1ULG3dWHHDXy5ApuNVs1XLO1pt1PIEJZA7TEgC6LK
	4nPo+FBFKERo32jF+4oRiqitIvSTm9xWR0G7Qm1L67xoqdGg9QrV8lU8mmCbZ8MNQNvmcoayhp2
	Y+Yb3k+3vXCmJekXvR98BaYYTg6/xWuDoWf9BeYhgN2awZzf9IUeO2j7cCDZEgE+I2z13S2nn1E
	FFhHXNxqAG+bM8P678W4QIJW74AHtXkhb84BVquGuVL6/tQ/RAKMTyWcyhD3x4k1c5xJsNWa3Ya
	dvDvY+JEKCllUqHpBS08tr4+mABsR2mqhEltJhsksrTrHL63SKTR70yDTCgO6PBocvDvJMxmkmY
	3fzCS7AfXw7JHRZRIKy3utj7lYSNufblg5/4jQwvfutXhFBklYh3vAeMExnsGugCB9I58YTBu2w
	+OebiZouvpxXyYFI/7Ty1xwJF9TROWLKMhm0Zn0o9W0HRSKSV0dVXYI0i7UkRHkDob4nG
X-Received: by 2002:a05:600c:354a:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a9662a0c02mr15189905e9.9.1793153719288;
        Tue, 27 Oct 2026 19:15:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c42b3c1sm10693945e9.6.2026.10.27.19.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 09/11] bpf: Let the comparator of bpf_rbtree_add unwind
Date: Wed, 28 Oct 2026 03:15:17 +0100
Message-ID: <20261028021517.1203900-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-187313@kernel.org>
References: <cover.1793147364.git.memxor@gmail.com> <d81d996f09e0fd0b07816dcd0541f39c0f451a23.1793147364.git.memxor@gmail.com> <sashiko-outbox-187313@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:21 AM CET, sashiko-bot wrote:
> [...]
> [Severity: High]
> Does the unwound path in __bpf_rbtree_add() leave node->owner poisoned with
> BPF_PTR_POISON when the object survives __bpf_obj_drop_impl()?

Right: with another reference holding the node, the drop left it with
its owner poisoned, and no add would take it again. The next version
unlinks it first, as bpf_rb_root_free() does.

> [...]
> [Severity: Critical]
> Can an unwinding comparator callback with a two-register return type clobber
> caller->regs[BPF_REG_2] in prepare_func_exit(), causing check_kfunc_call() to
> release the wrong reference ID and leave a dangling owning pointer to the
> dropped node?

Same as on 03/11: a callback hands over r0 alone in the next version, so
r2 stays the node the revisit releases.

> [...]
