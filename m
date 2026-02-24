Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2537882A
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930700; cv=none; b=msuCWr/+Lquvy9LkrQWMZEvnsAMqdNsXZtfQKe7Hfb89zN+tt9DTNwIr+/bPpUlUobBTE5Nre/p1oaw0oPHjT+I95bFX8MtVWBLavy67jORJrvPdy5ZV8QVPxMbqsi8JElMuL+Dzvf5A+/iB30lSFlL9xx9uAvxs9ZtsQS+fiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930700; c=relaxed/simple;
	bh=4oKOtmEtfvLwnqMA7pFkspC1lNzXym9piPx1zp9Q3rw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lKtTvXXfBPmzAivNbEM33frUncStQmn9vW0cQM2bMHxuYkleJDwHh1GoWG017sjzyNd01zTAd57aygQ4zS2+ECcObR5KiOER0eEXd1r+0nbJINw+GiuBZVNtiV+Ebb7EXdNaB+aBxX5NqI/p9vKZ04aqKusv8xxES6fPR+qyexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgohH7BT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+/mhzpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgohH7BT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+/mhzpO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771930698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oKOtmEtfvLwnqMA7pFkspC1lNzXym9piPx1zp9Q3rw=;
	b=SgohH7BT04LH6XWpuMtTQuQK9kbTmu2S8sZ0anfGrz9SWKgCGvrvHq6yw12oHzXAn9bim6
	6V70uxd8NXaOaHCE6SBU7owygfEI3EEAqDaAl84EJYgF9NMZnYzjZgVdwf/Z8Xpom9z+3j
	JJa/nXgKyAC968Ra4cs74yY4v2ZgD1U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-4w7BVelfP9-0A51OnlP_Rw-1; Tue, 24 Feb 2026 05:58:15 -0500
X-MC-Unique: 4w7BVelfP9-0A51OnlP_Rw-1
X-Mimecast-MFC-AGG-ID: 4w7BVelfP9-0A51OnlP_Rw_1771930694
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483101623e9so46962685e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771930694; x=1772535494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oKOtmEtfvLwnqMA7pFkspC1lNzXym9piPx1zp9Q3rw=;
        b=e+/mhzpOlzqxGLfmyOCJqFuGGlpTCu9SGsxQc04DDitfZhiEsjziHElnhLftZ4Xzx/
         b0QjB5DVxXS7GKJSSdljBVUc81pj3GGszpBYC1UY55hPQJxd2KTabheerFf9gA0aschS
         gRUWfQJaf4gyX9rSVQfI+3gidaJ4ZjPg+dB7IZ0EVnHNT8hI9bqoZomxf2zJCJ94Wh+K
         5ciGuuNx2a2v1OteTtDd+S1cvvBFNl7Fs3cm3JyLWxb2OdUlz+/Fv/iQmQNdoHZy+u+c
         5UmgovxLGJ8UVZsffdhuanLhL32eikzfcL4/dwngmobPz4xLd3tK/fKJ0wRX6+Yq+qNR
         X2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771930694; x=1772535494;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oKOtmEtfvLwnqMA7pFkspC1lNzXym9piPx1zp9Q3rw=;
        b=Bd+73McsEvdytKRo/doF5E7ltQOaKXxj7NwRoiKlX6JqYxCqz+mUiIN6hsYPr9VVkr
         CQgWeNOa7CNQWOcLJa8FDxf/13NgN1pacNmsMFWHRcvOXM7D39unsh4FHNx1XxOHd4gm
         z0I89LzgHsw91M09sn1MHdLRU8I/wTtKEUwtcNvdvIB3vRQ2RnkkmidGFXJbHvPXY8ts
         kh/zInVuNqgMFjL2/0TtXn+neUzPuAFtdemO8hrzyROurPVO8xDI6EKgb+ZEylF6pbhs
         q0oNpi9qHVG+xvQ6tFjrfSXuZYsfeYePdJx79y8OX7yBgFvjvYHl06V/oELOc8W/6wjy
         7/jA==
X-Forwarded-Encrypted: i=1; AJvYcCVdLoKNHt4VTm7fu5Aa+eGqUB3x6xcJ0CEjc3njf4zwKpoYlreC5AkMqvif/JErN1D86Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQRVAz2Ub7KAxeTEM/tm7Xs2mbGLE5hBmQ+bsrpWr7ZjpWc0v
	XKixBmOJlT+sCbaPwOAWOYUalhE/GZJZK+SfmCAoGc4N5qrNMbuorbjYYeJcr7sLDg1rUQ/cvXt
	ApBWgNRPQZX80M3XMZWUIMSvAyIwG/G/3lQaBBThT8wtidLIdr8xNqg==
X-Gm-Gg: AZuq6aL647rgaKeJhMXouqptDnSsQiEd9CkSxESKv4kabp8eDtBqKoiQQG/sFx/iTl/
	UYX/wHrPq5R7O+/8SHI5jCWjquGbxAEojwfpW485kF9j+uzIgmD7PeOOUqFmogh/0t3hBdXYeyZ
	brSlZ8cvXAJfbuQXxirz0cSAI1KKKIflJCMtA8JruMFnQ3Zfc/1toJ8TObrl+rnIy6QIQH8ueVE
	PNwrXmkWAsKPhc7ieXlYZf3L39r7IN9LYV01ykL3AgvSxjBG2X9cqnznExdiu7s87ZPd00AfYEU
	uRGn+iBnwyZDbKb5BtKFS5bce21KYTFP1E1fRQdHvglf6jSXoV3/k34MDBrQx0J9VhAQF8SD950
	eUttKaeMOkivdT9n/VQpcC3izAVr/ptE6mWNrr6v5gIaLQw==
X-Received: by 2002:a05:600c:c4a5:b0:483:a2ce:f461 with SMTP id 5b1f17b1804b1-483a95eb453mr192990225e9.4.1771930694324;
        Tue, 24 Feb 2026 02:58:14 -0800 (PST)
X-Received: by 2002:a05:600c:c4a5:b0:483:a2ce:f461 with SMTP id 5b1f17b1804b1-483a95eb453mr192989615e9.4.1771930693778;
        Tue, 24 Feb 2026 02:58:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm493903085e9.8.2026.02.24.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:58:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 478EF5168ED; Tue, 24 Feb 2026 11:58:15 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <kohei@enjuk.jp>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jussi Maki <joamaki@gmail.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>,
 syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 bpf] bpf: devmap: fix stack-out-of-bounds write in
 get_upper_ifindexes()
In-Reply-To: <20260224031556.38398-1-kohei@enjuk.jp>
References: <20260224031556.38398-1-kohei@enjuk.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 24 Feb 2026 11:58:15 +0100
Message-ID: <87ldgimmrc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kohei Enju <kohei@enjuk.jp> writes:

> get_upper_ifindexes() iterates over all upper devices and writes their
> indices into an array without checking bounds.
>
> Also the callers assume that the max number of upper devices is
> MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> but that assumption is not correct and the number of upper devices could
> be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> stack-out-of-bounds write.
>
> Add a max parameter to get_upper_ifindexes() to avoid the issue.
> When there are too many upper devices, return -EOVERFLOW and abort the
> redirect.
>
> To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
> an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
> Then send a packet to the device to trigger the XDP redirect path.
>
> Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@goo=
gle.com/T/
> Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device=
")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

