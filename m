Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D334041F
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292821; cv=none; b=Grcy02F9bGo78WKp68WtyCrM7G/6e22i/W24rKiytPrlluVTEIpteY3CYp3AMiJV2TUU5Lz2AWXaiXukDRpfsqsdKYyGbNOk0aAwRB2pxr2WBNc493W6/Euip8sjVDrZNrTLm7r9+YfkVg2E+wCNvbN8kNUPEZQUhMqXtxzGasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292821; c=relaxed/simple;
	bh=0KHnLGELU+7pMiO62FEG+LzHx86K6KaWCewfhA5dFw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuelpeaMEeeNLnUfVvo7JpYEQSl3awqMS7vKl6VKRYAwpz+HhFqAHPkOL3D9dS8aHOEBtaywkbC7RFcTmKIxPqjiKN2R7Va76TaO4eaLuaSKoOj1gT0HoejI3nkUgDmp5GMpOTEZeDTVHMQE23NoCE+lYCbtVe508LhDBderAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz3fbk9c; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz3fbk9c"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36a15ed5119so1539417a91.3
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292818; x=1779897618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KHnLGELU+7pMiO62FEG+LzHx86K6KaWCewfhA5dFw4=;
        b=lz3fbk9chOm/0ulyyFUG2MKoiR2XoAJQm6mL85IAcvzRBI4iCi/w7pytZPDqpcYukH
         V98EbYrhQsG1umraKjquJmjmhGLC/2UQwAl2a6d4DvU52y5nNM6alfyb0wmW6rghW74o
         hoYzLCqYn3vX9dmoWxESdbJvvNDmW9Xcd+H9hUe/3DVovZXNmS63zTTw98GdXEMu/m3I
         OgZOVgtNnRVP+mzE4UyFYZCR7EiGzOR18hdeRZchl+7P7nvFzaPrrLzYI/uHfDfZ4SlI
         x1/6kPKUCPEw+flqDz3MWpSCWCElnAwahmg5se+mrgjME/lVqkIjuZXiPyZBK5y9ncg3
         UFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292818; x=1779897618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KHnLGELU+7pMiO62FEG+LzHx86K6KaWCewfhA5dFw4=;
        b=AZ5nOtFax2EBxCavdEKZpSuUEy9C9v3KMHLGzngDQAsjKY12XGQhDN4y/1kTKkbw11
         +IQENLCyYyy5/r1Npgqmx0R3M5QN77jcBSDKyydlg2nGs2Nwusddbr1CPFVUnb4Dq3ax
         n4L1HFztBakREE2fEpcdNep6y9kc0dTTN3I3XsqzskN7yJTfxNAVGXCNm2QSsePlUuln
         uiy+cNjjGfCbWtwlBDmoEhnbe7eTpSb2aNx4cXHnqId/6RnNf75qDZrUMl0PvM+OhQBu
         GkhV4NjojVJRV6wdtJkJYO/QM4VS818w4rX30UqqO9iTEjTkUbD5c/xErP78BFQY4DWz
         oKaw==
X-Forwarded-Encrypted: i=1; AFNElJ/PS9P0yQR+35rtWAgqosjyWZTXpxdOnmpprkOo/hg5YTvN0ouvrqjb1ChYg3+b4pWhBms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJgwC1gbGJ06wV0YCUlaACFsUVh2Ooc4SBoiY5XcLvF1jq113
	esQFrlHDspu+O+XAmpsV6PFDMQrVfLxRfWcm9Wdw3ZBr6Z4UEqb896fh
X-Gm-Gg: Acq92OGa/2kw0Rp6rBsFNqSXwygKDPDNl286u9+tv0HMilAknQNqUGJXwge7tNrN3ib
	gZpW9blnTY82Q4inqaONjjUB5OnjTevmXE0PmP4kEBuedrI7OtCUST8fBtOx4vaun7HPb0mCQjJ
	RUqe01kl8ageLdmOlU/poewrGhH6QDpN+qzgss9rr6YI+XsHx9KxInTqbrtLAcEd4L6anhq6ZzY
	VMmdQeQmNkhF6A+w6dDD2uk1i5Ar1eJQCgm8Z/1R82DDPuFrX+ZJZjPYp8mOPDU4cTGZOy/8TNr
	Y9ageQ66846aAH0UZG5zJ2FJkQ3sOlP5krn1hXeUvoD52hhMEcsiX5Hh8w/VGRlHWzPVOAe7N0J
	9IynjBLp3nNwHX3/qytgZ3U6OFusZzBxfAO2sisfcfzt9619+NkpoRq4qU42T6HdoYzTjcFC5u7
	iB6sjgQ72ZTRpF3E+oG+NS
X-Received: by 2002:a17:90b:5904:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-36951c9f53dmr25356929a91.25.1779292817925;
        Wed, 20 May 2026 09:00:17 -0700 (PDT)
Received: from john-p8 ([98.97.43.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2dcsm223753765ad.13.2026.05.20.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:00:17 -0700 (PDT)
Date: Wed, 20 May 2026 09:00:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 
	2045gemini@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <2bojhuplzmn2cmofwusp72nds54usdcvk6agypz47ooninegye@rydeh4wwhvuq>
References: <20260520102715.3033936-1-rollkingzzc@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260520102715.3033936-1-rollkingzzc@gmail.com>

On Wed, May 20, 2026 at 06:27:15PM +0800, Zhang Cen wrote:
>SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
>with this bit set are copied before data/data_end are exposed to SK_MSG
>BPF programs for direct packet access.
>
>bpf_msg_pull_data(), bpf_msg_push_data(), and bpf_msg_pop_data()
>rewrite the sk_msg scatterlist ring by collapsing, splitting, and
>shifting entries. These operations move msg->sg.data[] entries, but the
>parallel copy bitmap can be left behind on the old slot. A copied entry
>can then return to msg->sg.start with its copy bit clear and be exposed
>as directly writable packet data.
>
>This corruption path requires an attached SK_MSG BPF program that calls
>the mutating helpers; ordinary sockmap/TLS traffic that never runs
>push/pop/pull helper sequences is not affected.
>
>Keep msg->sg.copy synchronized with scatterlist entry moves, preserve
>the copy bit when an entry is split, clear it when a helper replaces an
>entry with a private page, and clear slots vacated by pull-data
>compaction.
>
>Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
>Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
>Cc: stable@vger.kernel.org
>Co-developed-by: Han Guidong <2045gemini@gmail.com>
>Signed-off-by: Han Guidong <2045gemini@gmail.com>
>Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
>---

The bot reports are smaller fixups that we can add on top of this.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
