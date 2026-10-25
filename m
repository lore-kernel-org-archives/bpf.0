Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901042;
	b=hWwcACMduTygnsJYM8CEZWMXmYd54ecqyvCfzm+sTLp/E0E5je6NDbZDQypbs7G0qiFQ
	 Ndg1lWrafanDU0HauUaMcckhC1Wt4RDKy3PrGTAFeoajqYQzBHhlimrQPGt0+iDjobXOj
	 Eq3jKjq03x5KRq94Qvc9qtKta5KxM9qOA/CnTmPkIDctfp4EowMQGmMuvcMAdDH0q9JWJ
	 aVL+xheqszhsSflz/4SOCtkV49Jn8gjmCSk1KirmnImPSSLMQGcR1Qo67gd6SNPh/oa8w
	 zK46+P4hNOyJyq3Cm9+dov5ZGbm9LYkXnmMh3bDudtW/qNTY/Mqq5pZdu5iwKETBVKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gId09eW4/Psy0JauoROKgf712hQDkeOhkjrKn0dSNTQ=;
	b=XzFr1VmPZto3V7wBtQV15xSGo19x5k2zO/25x+ihh7z/sDJM+AxrtrAevzOCsaeY8XW/
	 Jqoc1QzLqi0EP5L5E7hZJmqiHUcKc1k6oB603W+M+85k9ip6xjIwiTHV/aLy0r2+yvrZe
	 IoSb/k15xAneG18gWsy929v9gyWN+i7cN1DLK2fmJIl6aKP3XM5w2N+YwL9YrJwbR1Qzs
	 VhDudXRk58x6z1goePIslmpmWVt3j5UytdAgcLdYn18tCAjoUpIsiqiztKtvvk48lLHyk
	 azaCTxNBm35HipIiWQyCp9dUs2lmjZsyTIQ2lFZ2FVAEyt9bWRxYYrKxIgM/jbFMP0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jCMZbZpH;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D81606A339
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 04:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D81606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jCMZbZpH
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1464018a91.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 21:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792901041; x=1793505841; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gId09eW4/Psy0JauoROKgf712hQDkeOhkjrKn0dSNTQ=;
        b=jCMZbZpHovCuF26jrCaIXkA0XyCql6/lsi0nbXXusRURQH0DQtsXwimLb5DEAkl760
         9Hk0Kgd/z3ATVXuEjixsqgG2gODGUZuD66AI8MY6dV9GtoxAgyTXSNp3UgDn9RlNvUrd
         7M71REEdijuGGI0suGbD5t/6WvaPxiXYKYuYuMvg/Dkz0hRdjZA4BMlEH4i2LXf4UEsI
         kSgqzrvqqaYMgWEX/kVBpRk60w2sOiKlqFCwY1Mtcb72hqsyboQTr/KvWkc2QObq5EJJ
         gevo98TpziMiDaevzd5fGX3hXfxu1QbaRBd2qO1hQ+IZdb35dOH/cHPVt1oHc0qo7xQR
         GMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901041; x=1793505841;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gId09eW4/Psy0JauoROKgf712hQDkeOhkjrKn0dSNTQ=;
        b=OkzzvVpS2jgU++YcUMXnaFFt5GM7xjuzxnx/sY2S/v6YfyOs7wUMDcHJIEJ0uzAwJ8
         KET56z8jPlYixEv9ctz2KrsMBXzTnhUSdfyy4s2dfuVPpmudKcTQ5ogWsPjtLuxZEaza
         wj9netBPJqIjzqSmPo2jLgiQIaQgKp6lmggJTFr25ozs5I+dUCv1iTxHZPLlBgp2KWmI
         JRM7PDa0KrA0PK4ALiK5EFPiXQiMnB4G0E/WCZNXrnKI/kM2M6AkQ7F9mnAj04nrEXoI
         1gc0RDe5Rs0xcMDIqkNnfOAaVqaB11jA/whc04eDuT6fYiGCeKG9VNX47QefTsrEmbpa
         AzTg==
X-Gm-Message-State: AFq9FYJQkJLt8h+xV99HezDiNob/YhpUwrvCMsgZT4i/E4IayU20fpr0
	YbJ/uV/xzO9pPS1ZdRqndpcRrQQZgXHxPTZo09Csl4Rjy4tAG3da4cl/4H0Vdg==
X-Gm-Gg: AYBFou144zAkaKazSsaCYizTRckUZFgQ9H45fMQ6qUFHqcayTByQyO/rhiA8EXTe6zS
	JZ6/SRmMeEluKqNjaur2aplCrucP9hgw03Rkl3999TdBfq/vvR6RLh0QWNJ14XrDLlxr7BOUcaX
	9ZdsAjXjGfZ7ue6iQGnXnYEwcWwicMlGlFWoLGWkUm3YCZ/Zsn1g8kdT56DQ23JhtenjWT4P6eQ
	rMLEExd5yEK02PfeqDMy0NgFRk4m4C2zWiL02OTM35/x67ks1SDFRWilHNM2GqX3OL7JgK/oeHL
	8SiYc9C5Gx8hS/Dsh1ohFzfowZsgCKRODaWD9+DiWsfhGRYfUlAc/Mak0I2xnjThfgJNRABnj7V
	stYMsosoQyjxJhJfqH8cqp+gCakwp7O9rVyDpBSLk3g4Thrdf8yIZzqh1BC/L8KKPJ9U0FGiQPR
	TJrWuzmzu1d6jp0PHDQKIkc+b8NNFGn7noOX4X1xG6YwKI4SfkOyArxNe8tV+AwZr+bKVHfeNu4
	Zbj83+lZPUpN0NSDltW4B9FYH6Lvs9AB3Yka3UHWHDXkY7WvaO5zAir0E620PkGD477Cx/Ypdz0
	N0HNPDsGHz/fCCgJvWL/FoSevb/l5ZHmtZ8z8zhGrJXm6Qq87y6agEZ/iDcc
X-Received: by 2002:a17:90b:4b05:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3adeb197eafmr2849652a91.64.1792901041321;
        Sat, 24 Oct 2026 21:04:01 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb1e37esm2940351a91.4.2026.10.24.21.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 21:04:00 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 04:04:00 +0000
Message-Id: <DMDMDJ9IQ9DC.2I7GCTCJYZ68B@gmail.com>
To: "zhen.ni" <zhen.ni@easystack.cn>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <akpm@linux-foundation.org>, <vbabka@kernel.org>, <surenb@google.com>,
 <mhocko@suse.com>, <brendan.jackman@linux.dev>, <hannes@cmpxchg.org>,
 <ziy@nvidia.com>, <shuah@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] mm/page_owner: add bpf_iter and kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <7f9a9da5-1250-4be3-bfa2-70e4b6051197@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn> <DMAURQCKK6CG.10CZ7MFXGJO3V@gmail.com> <d39db4fb-e511-440e-9065-72c34a1a295a@easystack.cn> <DMCCBEPCIWH0.2JEDKE64WPJRQ@gmail.com> <06925440-8df8-4f2e-aea0-ede1a98435fa@easystack.cn> <DMDAZW82I9LT.3FNX2WI80GNE2@gmail.com> <7f9a9da5-1250-4be3-bfa2-70e4b6051197@easystack.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 24, 2026 at 07:16 PM zhen.ni <zhen.ni@easystack.cn> wrote:
> Feasibility isn't in question. The question is whether we want every
> prog writer to reinvent this traversal plumbing, or let the kernel do
> what iterators are designed for.

What the prog and user space can do on their own stays out of
the kernel. The reason for the nack is the same as before.

I'm done with this thread and all of your future patches.
It's auto NACK for all of them. Pls carry it forward,
so no one in the kernel community wastes time on this anymore.

pw-bot: cr
