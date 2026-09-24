Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3D3B4EA9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263126; cv=none; b=uD6KtHtEPdqs95tKX0hZLz3ecKBJVbpxz55e6pGm2TfrezVRyWzhIfanLnbk7Cdov6jc+5kWyfb6kVp6CwO1OL9vqYYaRjiiOcpsdPYn2f77gAjOW6cZUrA5DOplxqOj/Zk0MB2S/E0xfeauILmheQXrhiksz+YgIgtNq0crdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263126; c=relaxed/simple;
	bh=KyVhCYgY9rZmwFZKsTNKjIAuTbEE12VWvSJbLhD9Dis=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=PKZV1otiY8CJgtCBQSMHX5MQS4Xm0ZZwVsHOWNHS5F7QmRROeFIUB4pw7Gp9U3KV9v5XuAyE3SB8XuTnIBrMKyFpwRykvocmbINiIJRxPCk6OsnmOOr6nkZn1V4K5LV5cX6bZonyZA2b9X3aQFm1zyogzXgkZgOWUA4Wj9aUL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHsM/OT8; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHsM/OT8"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0af40d240so170151a91.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790263125; x=1790867925; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rikX6C1NJPHapbEzeduQz6yoEmhEy2tbbFictR7Xy8=;
        b=tHsM/OT8OgqDt0LngZGotBrBOAFh2s0z/ce0IF6zzdRfOMiYZ5Br6GRhYkDLrblxGa
         NolbbmgOau8v84dCFeLGYtI1J5vzgfXSh80jfD+F/eEfU42qHx5JOht6SKkN7Pj0eT2c
         HKNd/5Ldn1TED03fzytIqFrIJKA2B42RdVPiva9DsrdYTKvxQWXiOYWjZzjlQWa38I6+
         /FmCxZ0saG8dkhAn1ZsXtZ2cS3VswekuW/PPpJwiyR9hb0q3cUbbWRcc5akr/qytoh04
         bju3WRBgMa1f+B7omuM+JJ2GP53zFkewjfdbSoIq2FYThdFfyuSoLlY0f6zwSq6qE027
         Uvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263125; x=1790867925;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rikX6C1NJPHapbEzeduQz6yoEmhEy2tbbFictR7Xy8=;
        b=E2O7y8i2LBxp3EINFarp2CVjIQN1ugXbafn2nQSaedxb1vMbprKrTm+kx1J0q+Jbr4
         YF5aOokDLUm2qSExhldv15RiDnT/DafUdYHXWVjSCApGDI0iPnPmtb33R2TkLtugcLJD
         IF0zXhzthaa8fP7rTdFgb2aKpJzsinCl7Te2MZWIZFPQBthz/gVLWDKtarqPnt4zC0cY
         8mSw0IXCJCbZLW9AwaXb4YWnXfT0nGYXmf3W3cWWPk4/WMnNpUCW9t+tCMkGKf8MH1XM
         MToj62LlE1tbfluuvOmn5oLCNOnXzWFj43wR5nQkkk8KkNflAdg2zqJSDCrQJpwJRoRv
         CNpQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6BQ8Z7NaJT9NgAoYXih1QovotmVsnnCJ8qNc5diEnCVfDO8Xy+6DC494MI4e8n8ZOsDo=@vger.kernel.org
X-Gm-Message-State: AFuF++kkPLIY66fWTV89x1jPvl7Ghed+sPwUtAltZROuiNOv97RJ7jVV
	rPm3S3zkcru1qp4IFyb6yZRd9ZAkr90nOxVAFn57ADULm9xez1xmJ8kd
X-Gm-Gg: AYBFou1CEYQlOhlZbRZbEzaMsfFXImSP+fx9Krxl8V/mOhvAM03RkZQlVJVAg6t25v0
	u+Y8SdMgVO5eZo44HK82ruOtsv9RElmWfFHtdTazzXztvi3X92DhB0YSi4qigjt17++omijla6z
	ZTfChHpHzG15CDwrTjDdM6Se2dScTlIlBa6XNc6Mu8UQswy0qNiAocCNbV3Fmo1QXdcdR88MnU/
	6yCj66AvO/E0/ncAXsev2LMNr6UbqPInmiItnLRq3hpG3XyM2+WETWK+J0x68v75t8KWix/nVVZ
	j0kAVYOa4DEs0JQKHSB+OIhUl2BdTKRzKZJMlr8Yg/Pshal1gode5L4Z+X8bktI0m3knxFT9ZRC
	JuRmfLImBnf/1MhyL/cr3Xx4RofiSB/upZt2+NrcL4OjLJP1SFYfRNuVv8ry1IQvWVLb/nGWhKL
	fvB9kcvVF4g6kQ08Qz1KaHTmf9lDLlH3O65cizn/2X+FHLywqTlBG2FAbPzYDxSx/WZezdLkSR5
	ySkwskLHkCYFyQoLpANxk0V+nW0l4qTIe0EOooFS8noYFBFubEzo2XsbMCwq1o9RbcKKZjB7znI
	qN4PBbzujDMbqA==
X-Received: by 2002:a17:90a:4c85:b0:3a0:aa65:2bb6 with SMTP id 98e67ed59e1d1-3a0aa65315bmr485964a91.29.1790263124457;
        Thu, 24 Sep 2026 08:18:44 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a08132842bsm4021209a91.4.2026.09.24.08.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:18:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 15:18:43 +0000
Message-Id: <DLNNB8VZKDR4.2L3UZSU3AP1S9@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <qmo@kernel.org>
Cc: <jolsa@kernel.org>, <daniel@iogearbox.net>, <ihor.solodrai@linux.dev>,
 <yonghong.song@linux.dev>, <song@kernel.org>, <martin.lau@linux.dev>,
 <memxor@gmail.com>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <nsc@kernel.org>, <puranjay@kernel.org>, <yatsenko@meta.com>
Subject: Re: [PATCH v4 bpf-next 01/11] btf: Extend UAPI to support BTF
 location (inline site) info
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260924111428.75957-2-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com> <20260924111428.75957-2-alan.maguire@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 12:14 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> +	size = t->size;
> +	if (!size || size > 16) {
> +		btf_verifier_log_type(env, t, "Unexpected size");
> +		return -EINVAL;
> +	}
> +
> +	if (btf_type_kflag(t)) {
> +		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> +		return -EINVAL;
> +	}

flags and vlen are not checked.
flags == 0xffffffff with vlen == 0 is accepted.
So are CONST | REG and DEREF without REG.

Probably should reject everything that the uapi doesn't define,
so that the remaining 26 bits can be used later?

