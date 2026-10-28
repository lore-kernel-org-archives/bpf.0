Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153719;
	b=suVrNDMj7Ozf8pOyldcQP+DN4EzzgBXBfB5Vvo7NWpWsNbiSRdGWmyuPDvAhDqRSd1i+
	 ReQVny8vbf6bK4vk4YLut7zAoRZPoqqNDP2R6F3YkhkwSk+AVupq/Ic/dolk+mPhDz/sK
	 V/K8paCjyOiBPQUy2dTwri9TlfebQrgOtBm/qXbF9ftw3q/zmuNJ8pm8D1RW7l8vgTvxY
	 3gXG9B6mrOJSY7hIM1xH+2mC+OTxFh89poDpGOUy1tDbbm59T75j+heKFkgYPVcEEavjk
	 8JK4FJw8tvxjQikiHAoO+ytnhGynKTitVj1UIBwp6giWD0xc6QIT+yKHbsClA12QWaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ythJh/XEdjQLlBAqu0wTk+8zuvCWvmDdvt1JWCENtkM=;
	b=i5RzyusdM9VkC0lW06NQOSnjt23RzrzTA0cZCx3tnDI8kBzbJbnKlEW9UbzIEuZa/N3k
	 iyyO2+Wjq2xvQ+sxnLoVsgF/84DwHt9UQC7rokILToC67dnxbAXOn+INwbO+DatZH2y8A
	 yBK2i/c1xuwPfOIRiq+Ueb34w+0Tr3Kxly44gIgyW7OzMP432jb4ZRgs0VmOBQ2TJ/pqE
	 1pVHX0+e5SP7O0K/9XaRk2/GR97vbvH2iqt+R7r59YY77EWvV5asniepwxV/Ey7QEKF7l
	 OJCvs/jz+rSW3wL13+yvd3glsntia/e7lR79EoKsZW8N6ascuCSq4L9VFSiDrXhGIGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RYIFiP/t";
	arc=none smtp.remote-ip=74.125.225.64
Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A5606A321
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED0A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RYIFiP/t
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48db76d98a1so154938f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153717; x=1793758517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ythJh/XEdjQLlBAqu0wTk+8zuvCWvmDdvt1JWCENtkM=;
        b=RYIFiP/tuYQsS4ZbB9C5og605ap8Mq8rqp1bwI7qrNEkMI7dLWp6qyimQfSkumq0Uq
         yEl2NUCbcdFCMfz+vF94B0stXzqrrDBZahIS5oV1AOZeQiHCrdR6OqIuQXaTMKB0ISBn
         Mytuw4MeA20t61k2DW0vxbPCIVeVlFWgUMuEuaEqC6Wcv95/5k/LNeyGMQj+hIE3QX5R
         eYrjGczNrFSS+eWoiEtLp9ML58XMvbGOmAFHUm0OUaDPHSGq/dtTObkwSMyaB9RfMC5e
         y7N1o8pgrUblAsElQWBsirWFm//X1F/Kqnld4azzFsodJO1/AUYLt5KbHX1y5aB6UBky
         vk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153717; x=1793758517;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ythJh/XEdjQLlBAqu0wTk+8zuvCWvmDdvt1JWCENtkM=;
        b=Nq1lhy6QKkHsExSwwsunWeGOXFzr5QnuTK3DhNPP+JRoWH2BwZbzKUWz8/V7mRJO/t
         evVUZzs/Iqa705fzLsiXJfzHfucn1mmsyFJiBiRTW79BtIUO6Gf17Q2yRoIFQ9Z28jTQ
         mcYWM0vhdvrHSWZGtPwE3eYkuwAel65yK3kM2i1ZXBZvBrLprcPIWk2esZpwhrTEWQNN
         pBVIT9A7r9KOZbFAo9ePEK3WmelUwpUhzDv6GeiEuIRm8KFFpxXDPxz8sJ+DDkhrwPXQ
         bjrEvLn+WHF4r1gqT7WgXZXdtwmignCAcuQhzjKXK4E4k6xO/uPNj2JZesBOoeCBpCGD
         dHtw==
X-Gm-Message-State: AFq9FYK+xcBoJR/LH0aaayeUmXzC/6STEYAT4OIM8vVcFxZoaB1PlylO
	cTQKUXrIvD5gqON0YH2ur9+kVo+JFunTy+9lQA9Oq0Jd3xnMtYVztQZS31sEfQv6
X-Gm-Gg: AYBFou26nzeVnBIBxAOBf//gl5PqQenzYoDIpHT/N7Y+KjkJl7NEmATIhP5xfliltXo
	xXSIjc7OQMHAtcI2bPR0mJ2bqsfwQEbxjDSRzg2JcWXd4VnXU/OeBFMsoyPfLtY3tEQBBbW/SYv
	UdGgJg2V0L+J+CroAUtRWxg9jZIyjoJuABZCcbsjyw4lHA4JT1D3w1LGjQ5ceG3ckpREwdIEvuD
	FGvjGfrPUEWFvQLXoLcgqk5B7P2QV3Ft7QtElBSF290vuGvIgls88XoFcnq45VYzcLJB3iCn3Xd
	jxTryp/n6JmoszOTssECToFI2akvgSQSBjUsVGFjjBeJIO+5rX/gX974377dKmcpJ3/wd2TITFf
	bKbVttWecJrVNebT5+UlCY1u2tzAgk088o+cOL2kF0+HJG8iM9aY/LVy+sVSRAJfbkj/YBiVMBa
	CEPPEOQn8OfMzawgUgbczJQ7yWN0bLH84dgONGtEPyud3rsF0o4G6N3DpLd+BUbALdykRI/0AQf
	L4AofOqYRJmsfoFIgzXwkCWYPxHW1xFxgVBfUkM5R7/cMBuxJ6TLoBsXATHNNYeD2OVlOilPkTw
	8sHM99lSqyppMBeblUvDm0Mha0BWRRwlqiaCvAupV0L2UCDmT133Zk1XrBj6Yts+f8RCQP7OBpQ
	SHLFl7lMGejVmUZaB7nDJfQRhVBcuNLXgpyNEcly0vKQWmUshZwiEMohY3ANwmxuLyF73
X-Received: by 2002:a5d:4bd0:0:b0:48e:20ed:d5e7 with SMTP id ffacd0b85a97d-48e5d5a3f0emr1828576f8f.34.1793153717206;
        Tue, 27 Oct 2026 19:15:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdf9bdsm24586614f8f.55.2026.10.27.19.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 07/11] bpf: Let the callback of bpf_find_vma unwind
Date: Wed, 28 Oct 2026 03:15:16 +0100
Message-ID: <20261028021515.1203900-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-187303@kernel.org>
References: <cover.1793147364.git.memxor@gmail.com> <9b98417904ec1b27a1b6e2d6a37b897fe2494073.1793147364.git.memxor@gmail.com> <sashiko-outbox-187303@kernel.org>
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

On Wed Oct 28, 2026 at 2:08 AM CET, sashiko-bot wrote:
> [...]
> [Severity: High]
> Can the unwound pad end up calling mmap_read_unlock() and mmput_async() with
> hardware interrupts disabled?

A callback can return into the helper with IRQs disabled today, with the
flags saved through callback_ctx into the frame of the caller: the exit
of a callback does not check the IRQ state, and the helper unlocks the
same way on that path. The pad changes nothing there.

> [...]
> [Severity: High]
> What prevents the callback from escaping the vma pointer (or pointers walked
> from it, such as vma->vm_file, &vma->vm_file->f_path, or
> vma->vm_file->f_inode) in r0 via unwind_exit after mmap_lock, rcu_read_lock(),
> and the foreign mm reference have been dropped?

Known class: the callback can store the vma through callback_ctx today
just the same. Ihor is fixing that for the arguments of a callback, and
the fix has to see to r0 too.

> [...]
