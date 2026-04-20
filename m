Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81A35F165
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697521; cv=none; b=KZ08GybINPu0GnjcatLqaLB1GGpm057RCT3U6yu5Kq5D8f0SPcd1syc1KGKsMetxIFSnJ4Y5/earvuDG2Xd5RsCzGblrWuGWsQgVFwVdBJAR3dnhRZ/jtPyT/37rCnRTK2bOkNvMT3oxYbGRQTe4OqDf8WxBBB3OZ7rM4gSMGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697521; c=relaxed/simple;
	bh=6TnCzJEi2Ou4Wb7VrkUKGJ3zVI+KPwjjD3uXvTI5lYY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fm689NWTdKtCdusypmzS6+/bmCBTr5FNJtgnsxZV/iOuzqiqpmpTlAhCioanwgKJoxxa81ty5Iti0gjX/ziMsZB4vyLpX+mIAcwQVeeSTAHvqzKvR9RunD4Yo4iahnIM+wI/NlYAYba2NBwsZc4gUIh96SOIe8cBuuuhR3PbCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQcCudyL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQcCudyL"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67e09232daeso1774955eaf.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776697519; x=1777302319; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TnCzJEi2Ou4Wb7VrkUKGJ3zVI+KPwjjD3uXvTI5lYY=;
        b=OQcCudyLZxN0tApW6mEXOYppDSD3KO2UWvrD466mEEggSnNg29EqAuHWqMrzqXcQLX
         z6YiE89UCeBguKiA2DE5w+v6n7axKKr16x2pfP1W6GkExpjWK9kmtUisYTxD27mP7h8W
         bsGDoaDz6m88n4LNJ3/P1P5AuIVwzv0IF4mWDN7nEUEsrpyxPGm3K4jaCxD6mHSobWut
         a8mfHmEQNJ+lV5N15wrMk0xWVoBLoB4M8iA+EGtCKB+GWTZauvGwmJx82JVF4+6yV3/5
         v+CM4S5uKnsVE5knXpqqle1oCNhk1I9DVr2d/vX1fcdo6H1nG2k/ILPescmnJvYbdFun
         2Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697519; x=1777302319;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TnCzJEi2Ou4Wb7VrkUKGJ3zVI+KPwjjD3uXvTI5lYY=;
        b=d+/PnH/FNgzBgH/P2xMIIT7H1Toa5BbEXEhbNm6+Hny4pwjoVK9ym2LxfxP+MSQO3y
         teFnr8hK7/fZa+XrX+HxmKSmqtjUjbnZ0EW2THoLkhs8RNcI6NWC0vuLpjOQtBk9qS19
         g7bpVxeGX1zDfV5YQnX9P4W1NhiZTKmVpbS7yYa8vWzdxnNRET9U4A+YG9ceVpHqzdVR
         a/d8hrSFGHg3ovI/tlGaZ/hgjVYwZqkWpK0ZlYT7heU24ueBky+EMOxDESD6TrbZmmbg
         1dosVNqD99b9SVHev3FCFQrOkgyKWikBkKW7iuLzcre8QohKJtovQVzuonD/ySGiEhFg
         XkmQ==
X-Gm-Message-State: AOJu0YwSRtmxvglXyut+/+AGBmJCg3V3dVgw87+lXvdJYKavHpQWtD8D
	lmRfZ/W5DPTqERfYFSu++GkzRhpQMR2VQ3zJ5O+HQA48S8yUx+fVa7Q0
X-Gm-Gg: AeBDievEJ14vtn8Je7NcYdPi2tQZMfY9S3ql/hmMqf/JeZ3susohCPPBYhbrTDQR55W
	5hsPjdQlgGJnXlHDZZxRBcDpWtMjv9fkeAmfOJZrFCTaPlwFNBvycrUIwIOeTnaCkMnH6ll9zdf
	WHyVy+iw1OGASB46dy5IuAzMNO9/Lktn8XYBRgLmN6klbPQADfe5GbCmIzua6GnKi5+YVDU86KT
	gW5An2hcTPk0xlwiht70ZS1NOWRtWytGmvGuPJoaIHvTDGMvuSIEUNTHuD7m8vGuO9bFU8z0ePw
	Mv5ivObUGTZBOLyvYIUI9EcJTK9IPjrJGy5XIMltrLXFTAajmAK6EmjD8i4/nLmAQbnpw/tDSNp
	1jJDh4IoFtkP8U1Xj4e5Sbj28kpiuQPNNXCIdNX9WO9SRscY39XLrlXiOjytuE0moCIiM+8F4z8
	g5rJzirRzZq/x0g4sMt114Ds3uljgW9sCABZ24N6F1QyFTdpzjDadlrm2Z72AlrkN9IW5Hdx4Mi
	q8T0nwXvFkw//cRHin56mBkGG6d/YKQvEVoRPE=
X-Received: by 2002:a05:6820:f08:b0:684:47f7:a1a7 with SMTP id 006d021491bc7-69462ec8312mr6973618eaf.37.1776697518444;
        Mon, 20 Apr 2026 08:05:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-694852b64f2sm1607008eaf.5.2026.04.20.08.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 08:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 08:05:15 -0700
Message-Id: <DHY2PEXH9GEA.1XOIVBFWLLFIV@gmail.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Eduard" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Xu Kuohai"
 <xukuohai@huaweicloud.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Yazhou Tang"
 <tangyazhou518@outlook.com>, "Shenghao Yuan" <shenghaoyuan0928@163.com>,
 "Tianci Cao" <ziye@zju.edu.cn>
Subject: Re: [PATCH bpf v6 1/2] bpf: Fix s16 truncation for large bpf-to-bpf
 call offsets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260412170334.716778-1-tangyazhou@zju.edu.cn>
 <20260412170334.716778-2-tangyazhou@zju.edu.cn>
 <CAADnVQ+m2pFaPbRi=A+tsROKP2CPPkny_LXUKR3vUgH2+u1jRg@mail.gmail.com>
 <c93818d4-a556-48bf-b7d5-b5ece41c16bf@zju.edu.cn>
 <34a15577-6624-4bbc-a435-17b67e50d2db@zju.edu.cn>
In-Reply-To: <34a15577-6624-4bbc-a435-17b67e50d2db@zju.edu.cn>

On Mon Apr 20, 2026 at 2:21 AM PDT, Yazhou Tang wrote:
> Hi Alexei,
>
> A gentle ping on this thread.

Do not top post.

> If you don't have a strong preference regarding the target tree,
> my plan is to rebase this patchset onto the bpf-next tree to
> resolve the conflict with bpf_find_subprog().
>
> I will also include the fix for the run-time OOB read caught by
> Sashiko, and send out v7 later this week. Please let me know if
> you'd prefer me to take a different approach.

yes. thanks
