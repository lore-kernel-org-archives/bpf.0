Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153726;
	b=HlXCD6EDYUgN7CZCQWya7RBT/7sqp/XzS4oG4Cq1UDLrZftQMf22oMkyMMbSXUWTjohk
	 vuLXtYruQvIIJBGZsb2GblSZvsxPTpNkdRPzvIxIJo1TPapYxs+vjwrP4P3NWp7Rpkchj
	 T/hbN9NinbaERgcolufMVsDtb1wQNi4E3pntgVzVp0D2e0c+9Xrk1vvSnR3MAkk3AwMCB
	 7nW+UcvqEwdVuu2Qp7fMmXUfphmTKzTy0y2lXkJyQdw9L+ONDoMycmgXzQTrYYnVtEa5W
	 C8T33PZ1meI5MkgcfiX3NwrjDmtH0jkBBSPieesU6ltiXOWZs9WVnmnVOmjE7Tyj5yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=L3Rtk59dw55BG6bsRQI/hZ2qYqqj/drTH9LOuq53wMY=;
	b=eFhCjLEHtsRIq5P8T5IycePLv/aYafWVGI6Mg0rQ9L9H5T7iSml2xXhu8+r767BOd1B6
	 /uVAAsBDMdEdw7kuPEJ7Clfip+c6GtgcubjWu4RS2euSksV5GhCPOtcrRxSN00yjTh7Ao
	 cFhmSwSW56NuR7wbDvkeAdjywBapd4Hjn3PWaLv1f7Fh+WmMFjkUoIWtHzhVz+dXYZDf1
	 2fcjprf/2TIwiqkebUP2nxPs10znYSeaYuI7vbYmCYesGSoA3fC0EKK8NzCMr17jyugBU
	 o7VNOqmSyz4gfT4NkUEUIOJEAeZuiFKBULEW1eeJzC7ls7D/GUVREjHrgbdP+P5u08A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=piUY5jAc;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40284606A321
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40284606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=piUY5jAc
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a611dcb60dso1228805e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153725; x=1793758525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3Rtk59dw55BG6bsRQI/hZ2qYqqj/drTH9LOuq53wMY=;
        b=piUY5jAcD7qFeY+fnarTDVzPlsVR+v/sWZWt9Bc4V0wL+owv88kBFfl+6ay6Zlze42
         fJB6P9B39CiZJcyazvcw8FHc4RBtqslnoqhy9VQrcROZC5cGb33J5VMUh3+xt5/l63C+
         vuQLiMa386S/WpX5uy06EmlW/E0bgMFzhg4/LKICSz80GJaUqiD+Yi3BPnKOeD+2H/zl
         8Q9fbwzFeVMGL4CViDgSSlqjLZWQfM7aPdk4Fd4cIoH/aenG2MY/wOd7CyJOJziGtskV
         ltJhyRQHBLl+nnwL3AvH1NjsfW79qQmGgjz8hh5E2yvF+r0njyLSe6xs1XYgZeDtYyH9
         04lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153725; x=1793758525;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3Rtk59dw55BG6bsRQI/hZ2qYqqj/drTH9LOuq53wMY=;
        b=RU8bVeVSL16y1jQw6KHNhfrPJhQ4sDXucsFrS+ZUUatGREUgdZo9pbX26GkBEMBvej
         PM2Xc9H9mgV4ni0m/durjwP1zeTxYrpNkJjUlyRRCibZFQRw1VRrpdfambdPgLboiiT8
         3bm1NaMPz4FbZRM/78ZmCGAv7qRB8En8s0II9Pb2r6b0KXlG39ZaQVFFWdf8RIUqCPlY
         2SLxbNyCJU11NRKKCUDAH6uJfCSGWvQ6PGyvnXYH0FBpevIaNpliimvBcJnNsQmmCZOJ
         THLIZTgmgDuM+GJpJ1apt6MwnvPd0XYFoFGrdBCuYiv1nJN11i3WVr5LHhbi9NCopXq5
         iceQ==
X-Gm-Message-State: AFq9FYKU0BTvkrk9N0zhT4NAZbwwTCA/I/bGE2Lx/Ca3l4/pRlhjxcQC
	/VhFtVUPiiJcdx7iEIdJv6JJNBa4ZWAw9ra8gfRgdYkzbhDgCvTGQe53R+XG2gVm
X-Gm-Gg: AYBFou2zRn8w9MYTC+O9J/sJRyGDcs/q5Rht6QzkSn8yWZVzvpYXs0zoTFVUfPYy9Fo
	0bNX7RM7+tKfx9cLF0N0wJes+RwDcX2Z2cpLPnx22MQOeDTc7rdYu45fPaxN0saq4fp5vaLbxBe
	IKUShhV/FDJMTEkMj1RIASAsud4DI88EWeefCOwg5MnKk7jhM/va/kW9Zg5U6UIAHoEjbqxlCP7
	Mh2+os6Q1h+9c1LRwrQ3N0bZ/j13Ej64PaL9CNaETaHPv6dNIehirdtdQ3xmMTR2hQnKiE3v3b9
	waHPEHCwyHacxvA5mYVXg7TX7x5qP2xgH84QbTTWNhbJKRGYPOpdHqPphdv0laVcNrzE2Hp/5KL
	MZbr9fUIM33+CjwvxM/IqvfWEBls2iA6A1HRyfPAMc2QgNE1N2VQxBl7bWvTWuRigdkJs4oJxfM
	lyUBs6iTg+6z6ekEwh0nVQq2JYv64F92I7/CTJAkhP3RQdV9uP4UxxFdb5uJCOI4Qo7ef37G0Bc
	C9A7bsDDvSM/ic8/44J58kAwjxLEyA1I8QCkKDA82ZQLH+6zomOO10lpHSYd3HyYyq3HuqQBKIu
	eHlwZaAYXgQeFdbroiU85YheehEks3RtaGJGk8A+BHFUZo5SPiyh5+Wwdr6QZpmQJUmn61PgWwK
	Voi2Zd+KganBwDBarIZ2VRHpzMVGyma6EZSgqh/lHAg9lZLdpyILW4prpshhA5oWN18UM
X-Received: by 2002:a05:600c:a103:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4a9672f98b9mr11262735e9.31.1793153724657;
        Tue, 27 Oct 2026 19:15:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9792269a7sm10265525e9.12.2026.10.27.19.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kkd@meta.com,
	kernel-team@meta.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	mason@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 06/11] bpf: Let the callback of bpf_for_each_map_elem unwind
Date: Wed, 28 Oct 2026 03:15:23 +0100
Message-ID: <20261028021523.1203900-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8b767073e860cc55e546b7d5e034d3f757b91d207627e92aea95112977ec002f@mail.kernel.org>
References: <1b3fb00521b2eda1ffa902ee6e413d30b677bdb0.1793147364.git.memxor@gmail.com> <8b767073e860cc55e546b7d5e034d3f757b91d207627e92aea95112977ec002f@mail.kernel.org>
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

On Wed Oct 28, 2026 at 2:25 AM CET, bot+bpf-ci wrote:
> [...]
> TL;DR:
> - Array map callback may return a PTR_TO_MAP_KEY to dead kernel stack after
>   unwind, possibly leaking stale stack

Known class: the callback can store the key through callback_ctx today
just the same. Ihor is fixing that for the arguments of a callback, and
the fix has to see to r0 too.

> - bpf_unwind_leave() may misbehave (WARN, wrong return) if the helper is
>   traced

Right. Every function with a pad is notrace and no kprobe target in the
next version, as the verifier lets only fentry attach to a subprog that
unwinds, with a test that fexit on bpf_loop() is refused.

> [...]
