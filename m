Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AE3F7864
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252633; cv=none; b=My/TEjcMNhG1H+J9OZnLfBMVoRhzYsmNqOA4TEsBnFsIrzY6ukENv097b5PanyPDoultRTd8xfdL82VRZThyXTRIRnWymqGPm7QdYGdv3+Nx3ZiyAHgcvzeqY9MWWjsr/JaF5J77veyCYtld1Zhv1FIpSRCgXL7PLmfY5YR5Ae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252633; c=relaxed/simple;
	bh=KD3nw7Ltczkx1jI5uovKefPtMpE0/TaBF2VlVH6+8Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X021+TzXIAUy1w/iaxGGmg1Ih1+SU6KirbDaQpW/TVN0k1FUXtIDGjxXh8T9ACpfbiTzEWDxpdjzOgecxl2xNKnopifK6ObOSqm0TzZeKB3O3aHOXSeCr7rxlfNASyadfxuO5YgILtc5q1gwX8eWeXOw/k7VBpCkJv/I1LnVIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZprT7Gbz; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZprT7Gbz"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ba6485d219so14093655ad.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252631; x=1778857431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=du2JzkQKqlNU0D+Gab0Zj7x2Js35Jp0EtokGh0n5n4I=;
        b=ZprT7Gbz23RwV74LMuTjFmcaqjhFvlQTecnvgQAQLFEnUpd0aHMYunxGW4YNy0VxWr
         HG5MKDlj52fiHFcmw6Tgx/T9QUKf+6i6SaeNE0yvX3x8xD53kOF7sxaItyX4yev9AeNC
         22CH6q02MVLexWSx+nXSLfWTuxvsa34syJ1i7Tld9x97W95X7UK5oiWuuvbygP8wqZNl
         on43jDx6CMT3zkR5RXESsBKizjtCzQH/Zy/aBpsqisGxcSWQaAHadH/JlYssp7zPwopt
         2y0/bsWPBjgyPtea5ttmqhXa3ofs5cOXAF5CZfR5j0pqQ33ongsMZwtz5+VFYsrqaJAH
         1yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252631; x=1778857431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du2JzkQKqlNU0D+Gab0Zj7x2Js35Jp0EtokGh0n5n4I=;
        b=WAZv7oMcPQxvVDbXCdGK8sz1xj4FM/vnsdCLezCOc+rlE+IPzV8OtlOQvyyOMDFEpf
         W57gYPxW/PqPokpK16IneuTbpUcqrWfStzXSRbKTgtURztAiQjEyK7YS1DDF44iEJ0/y
         IfC99b5jTXxg/MGNc8dMUPHowxSMFXYThET9qRH4LENArxzEuVia/asLuywNyFE/n4Mi
         VcUGA+HYELf1BC3RamuNC3BkNSNUEqzi2EgIQ94v9UyoEp2tp5JlMPUJglLbmJeqXoPO
         AoUd8BnS7LXNmUPZmSlK9MjapDWwgUMEagLUGMbGjeY3Q3909Sbd372lZxwAAtMUSSzx
         n8Iw==
X-Forwarded-Encrypted: i=1; AFNElJ+7SMdGnGpftGdZTNYdGSJ4q5JTV9dtlSf45KJiJSeH13/aGtejyr4aQnA8ZSiJkObMfiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zh4fGFLWtQT6PsiEmxKG/BD48MkXBL0NNuAKAnP6ciGOFQbV
	YuUpivvMeqLKRA1Lowe9lSwrS6C8oq7PPb7N62J+JPQsZVzsiweqffXF
X-Gm-Gg: Acq92OFgCloCX+ASa8btWVgPemKJJ4LcMWANXIY4FSmJd6esJg9/ZOeXQKzREpUX5rt
	TeV5nY4Rdn0CjZT2H5lOxVEyrXNLcuObwx+J+IGqW2Khsah5Nww6ROZ8YZtDV03eoF/DLmjQcC3
	0HrcsIis5xqKUk9jJfwG4y5XKTxmMpM8pAL+mYWPlfIVJ1nlPSOkm7t271irdDL4rTCOtViD68b
	lP8Ezv0cv5XHggLNAQzDtLLSwqese1Cjop3KR85Xm6keSajD+lvhwzWlTSud9q5Gexf8uqc2oe+
	0r3GYaL+q9CGzQH75cvhET5qrm0NRdb1dtiipm7h6is6Gsc/V56dDGK5XEoH7oZuBs5OEjSBRSJ
	Lo9q89zgHjZoGzUGGkPXk01rd20cth9Knbz4/HWnkqgfIIDwwOFc59zcwjt6TFNP1YOyzovw1zv
	+29Rt8tHAB3b9VJuDXzpG832T8Zy8=
X-Received: by 2002:a17:903:64f:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2ba798c27a9mr92826425ad.23.1778252629752;
        Fri, 08 May 2026 08:03:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e9fd64sm22598665ad.69.2026.05.08.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:03:49 -0700 (PDT)
Date: Fri, 8 May 2026 08:03:48 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 8/8] selftests: drv-net: add netkit devmem
 tests
Message-ID: <af37TYtuxGHh7crM@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-8-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-8-52821445867c@meta.com>

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add nk_devmem.py with four tests for TCP devmem through a netkit device:
> 
> These tests are just duplicates of the original devmem tests, with some
> adjusted parameters such as telling ncdevmem to avoid device setup
> (since it only has access to netkit, not a phys device).
> 
> Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
> BPF redirect program on the primary netkit interface.
> 
> The NIC (HDS, RSS, queue lease) is configured once in main() before
> ksft_run() and torn down in a finally block via cleanup_nic(), mirroring
> the nk_qlease.py pattern. This avoids re-toggling NIC settings around
> every test case.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
