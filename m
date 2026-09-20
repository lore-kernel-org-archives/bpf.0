Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E603328B56
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921066; cv=none; b=XJnNXVg5aM7n35VU0IVWlNFMxPjcGjacMzpttJBNY8Z5K2nBG2ux2Dl6niUIxangQjGlyN7nlBzVeI7gbjwq7a1ZNO98+i7V39r7q11/Z29zTQXI7C0D0J2MwH2oA2ciorBl0cAIa2LNghY+JqMSJcxN5GNyH73LM2Sse1RZbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921066; c=relaxed/simple;
	bh=q3+uLqBCNGSzkE7tv6YmXIvrM+sKuNRFRAZZq6awJKM=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=pMF2TBJ6V7R4uUi5ZLHtHbaOzhUmOgd9V1GYs+erB+3oIvRfcwCpOt5lcmBfxrbqtc9BLEY2QygzFMpH9R1MuURm1MLgzPUgwCy3kExLWPl7Ug8sVvbgPHLxYl5d97H7xe1rI7DouKzBBgcRY6CZtU+UwV7HgqR6M38f6Bg58B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duKHX4Dt; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duKHX4Dt"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-868a9c48f9eso2789479b3a.3
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789921065; x=1790525865; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDlZ0Axn1IVbcM7wq+/bUYuF1RFbaZNrtATk3Wq6DJU=;
        b=duKHX4Dt8MebFrNKOBbwKA2zHIAc5hYGd4rZx9EIq/TFka+FWnjzmOfANMEadtVZaa
         kz1z3TP7YwkYEGG+UFUA//LL3YuQesxIUkNWyvhnr9MS6c6SMrQfRMBdUHX74hHb2Kbu
         VRbcwEfgS5YO9rD0BTR4oujohJt+MsTbwrY1WYxSPuC//gjd2GN3zUQa+W2bpytcV2bq
         mUv4FIBOMPlg4SkpDrHihSaZdEQlMpdHxo4e+2i4HS0XRv3tDxjEHFCx/M4otdm5ZElU
         zUkjvPY1Z26Zppry1wxFyP2neIN1nfe1jGkQGzPHCEkV5UYRRLO2WHX3gx5iO9Ee6g6X
         InkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789921065; x=1790525865;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDlZ0Axn1IVbcM7wq+/bUYuF1RFbaZNrtATk3Wq6DJU=;
        b=dp5skiDCHDVmS4PcLBMpt3pJfKDRUDtFe9t/mJxsKhr/In56eM1UQd8gSphsZ5P9Qk
         T/B1bmryzjZTK0GbKRKqQsXNVeKN10ycC9d2npi9Zg4K2/orPMAKhAMycRLjr+LbAueP
         d/1ZGuNVFiEG6I/Q+8oz9y9Rvmeglm8fNlpyRDQlQDlEr1N744OLY+QiDYpGKKLvvdr7
         1VxqN/Eqd3j77KdQ9hGQVS9KmvzRQklYHaQtx6uLgURb5jJQw7wFGyliUCE3tg3DDy5Z
         TyouTA/0hfyrIi8zIeFl4nPIiK7ZDCfpcdLoVoGR0oUMpc9hfgtY1hP5tIomWEy+Tfdo
         7i+g==
X-Forwarded-Encrypted: i=1; AKwUvBzVqkDdKDVrdgqTwOqjHC+WypIWMXdKFJeFDuBMN/mdj6BJdH7NbuhQxwWQzPxvRwIg1jQ=@vger.kernel.org
X-Gm-Message-State: AFuF++llCXPWGkcP4L4zoWuRlJuVX8HeVTkZFHb1SVvl8SXiefpv/PiI
	bRtua7Rrq2QhwTKaB+2QWpvj04NT4pyhmQvzO9HvwQYTgtE/sJSBcFFh
X-Gm-Gg: AYBFou0ET9w36+E0XQ1rTFtcfHP6gO2jpBGUIBHHRP7XjUMiMgZj5Yb4Eb2kVQd3kY4
	AeU7SjrtcqTf+oaUXTsnhQrCDlpO7CulQ9DisiGqqFRk9EHyR5CMnB5MiRwqxf/xf3V4LhcXq5a
	7a6kNLiZmdqbaBieDvgU4IgYsXo1kYw2GS4njnOnq+fUEnbN9DIOa1nY2m3AhJ2IyeqqjO7i7VM
	ZjY4poqXoxfl7v9dl+IjVXgSx8f8Zbh0uzKwsttFtgVjAA2CIfRvUKE22/LvXgB2PGsGz0lT9Ss
	NQtsbwJ/hCdz0GX3I2fD6dTI+pg4ihaZ/7z2084u1mIKCvrrIry3LIZgBAB/YljK2X+jCAZZokF
	ePi4Jk3BCCn6bnEosp1VaCgcycGPt/r9Vs85Gs5Nlpiyh/pzn2nKg5/Rl5JWxSIlGxBQRu54+da
	f4GAx/j2yJvtbOXdCMz4+16nAkToUY2Z15xtrKuCrRWPZyUoO7XmiDaBzmDQU6k0CTCNfNgx3QB
	wAKbcHFum/h9Yze36NpkLBJqp3isAL6LDZclxxT5dXWlA6Hjm88Z8EoeGWeqLR3p1qJY+4GtmID
	xNw1
X-Received: by 2002:a05:6a00:4b01:b0:848:4faa:480b with SMTP id d2e1a72fcca58-874dccf8702mr13211565b3a.12.1789921064613;
        Sun, 20 Sep 2026 09:17:44 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa6fd3ecsm2107269b3a.59.2026.09.20.09.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 09:17:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 16:17:43 +0000
Message-Id: <DLKA28VU4GIV.I4EVTT076Y5Q@gmail.com>
Subject: Re: [PATCH net v1] bpf: cpumap: fix use-after-free of dev_rx on
 netdev unregister
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <netdev@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260920133017.248620-1-jiayuan.chen@linux.dev>
References: <20260920133017.248620-1-jiayuan.chen@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Sep 20, 2026 at 09:30 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> So do what the softnet backlog does and use the netdev notifier:
>
> 1. On NETDEV_UNREGISTER, take the ring size and ask the kthread to
>    consume that many frames, or until the ring is empty. After that,
>    every frame that was in the ring has been handled by the stack or
>    dropped. The device is closed, so no new frames for it can show up.

That's not what the backlog does. flush_backlog() unlinks only the skbs
with skb->dev->reg_state == NETREG_UNREGISTERING and frees them.
It doesn't feed them to the stack, doesn't touch packets of other
devices, and flush_all_backlogs() runs once per
unregister_netdevice_many(), not once per device.

> @@ -528,6 +576,11 @@ static void __cpu_map_entry_free(struct work_struct *work)
>  	 */
>  	rcpu = container_of(to_rcu_work(work), struct bpf_cpu_map_entry, free_work);
>
> +	/* Unlink first, so the notifier can't wait on a kthread we stop */
> 
+	mutex_lock(&cpu_map_mutex);
> +	list_del(&rcpu->list);
> +	mutex_unlock(&cpu_map_mutex);
> +
>  	/* kthread_stop will wake_up_process and wait for it to complete.

After list_del() the ring still has frames and the kthread has to be
scheduled to consume them. kthread_stop() only wakes it up. When the
device is unregistered in that window the notifier doesn't see the
entry, doesn't wait, the netdev is freed and the kthread hits the same
eth_type_trans() UAF.

pw-bot: cr
