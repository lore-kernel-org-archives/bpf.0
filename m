Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5873385D60
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790835283; cv=pass; b=OdoenhRYu0onCFFh24G5A8xIVgyx1BdfJ4ki8g9Qv01e6HndDvRv+lV3TZejv/UmmQaN7SUJPztBAmahpOrW63dUJpnQvUJvrDWi4TbVjFBBWqlw/Kv7mQCKN0vW0LAsCcgkMLe1t/SB2DEw8xJeX3q0kfm0qSn2qaBt5h6O00Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790835283; c=relaxed/simple;
	bh=39n5+UyA9PRDaaatBly66cHBaTQdgNM7PETxUHwKMqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvxAWptWv7YbjOSbjt+1iBcpo5oLXVlvOWwiJT5R2Kz5pEIrGSqq4YKS/Ve7e8SsfA4LTGH3s62pn063I6VA5oCCB40nlMlqB2CaNZyZXJ4Sejup9UWVlwupn329Ndv9q/vxgn2QP4NT+RDgJUWUM+lgch2YOXCmjMEErPzeqqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SosygpG4; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SosygpG4"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320dc09f3so49516671cf.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 23:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790835281; cv=none;
        d=google.com; s=arc-20260327;
        b=d7Y2/9AMUbmQr1FtYwdnM+f+w0vAnX/y99jzYbKbqWhii01Mgac/kQ/In5EmRFbMO8
         vrAItLwfPc5Xlf0j99z2PJfyGr8NXqPMkwdALsVQPquYITlmGicwZzHVOod7XEb/iddo
         1ik4Uei9hvAd11puyFdWIzIrru1BYDX17+0CA0srpFD/4VK8L1lNKmgPKF86q3l3pO8L
         vSGzyjUi923Inyo5/eeojyfnhX3PI1Suee+6h+UMVlhtYFqw6b8vzfI/yb/3UnM20hS9
         C37xcMV5ojXGztAG3y5RIQgFbxVYr+Y4av9/gazNKDri3BemVYP/y5+c+nYVWu+WMWyu
         E62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=39n5+UyA9PRDaaatBly66cHBaTQdgNM7PETxUHwKMqs=;
        fh=AA0GvUieA5OYh4JEHWZH9Yet1G12nfZ1foRrVMDU6E8=;
        b=hEfJUDOjLZAgFidGUNG8aVeSsnzkrxrl3Ww4WzL8i0n6mHXon72n9BkL2WBQQMl7ik
         aXhoBU6CwX/nH7MBMPUCKmQYfpBsIYXfyubR95oTIboluZ0YRNxkYyS8m2SAj+jwdhjS
         fuCo531X0hLVRxdFTKb2vnjayWvcNOaSBH7KgvSISHEngQjs+0vnGPSklYm3X4KHXfS8
         yXrzEe1Khxiq94qO4JU7aM8U+gHHq/vfuCPLqNv92g0BAQQVtCVomu1dpgJdrsVeutQP
         tg/Z1V9eAhL92uKjhrHnn9rLz3m3VlEUVN9ssWungBcdSauYa9m1BxvJbm5Z3PXoHEQL
         v1hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790835281; x=1791440081; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39n5+UyA9PRDaaatBly66cHBaTQdgNM7PETxUHwKMqs=;
        b=SosygpG4bRzX582tomRJC+0rElP1Xr1V0kIWBzY7lca8/4JIxAdaYjao/jTLgWNF3l
         nD9v/tCzJ9MlBophwxw/4XcI0Emy3I9kdoML3/kJiihQzbtNn0zc6sc1hH/kKcHTHtRR
         6jO1OEEMvtiODWbNUtsGpqRk0EwlF0qqH3i8kWxSXYm2EVccl1MRKJYB34K/+64vEgLy
         opEEpXDhOanRV7zlWpLmcyTFaL6mNC+qPAxdaICW3tg0wl4bOwGIAS5y3sLA4RXewkDk
         97tNv0e9kkgkdPJc6HeDCJKx23R02KxWIDMOXTiqU5j+1JyBgy/WICvwR8a71PLXbz86
         +pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790835281; x=1791440081;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=39n5+UyA9PRDaaatBly66cHBaTQdgNM7PETxUHwKMqs=;
        b=HgLYQfQe7dNwChgdu+WivkZGJE3hIrSQN7m1r/1+eLwq0dHh0VU1LCk8Eljaj8naVw
         OZQ8rb3NLdJqOXEAIaazDTDlEWlzjQi3kjtJ9IQ2axpSN0ZWtZQZE6kwYSeJLZ4w/R7N
         wgjWNe7E8HL0Gkdh7YB+/kIQInfTRMgpio758CmkVvGTTU/JbqNjuvNXiAsu66d4v7yG
         cklt/kDGMyea1/dAcEODuyGroy8dSsuwseolgc8R4Kypmpwu9Tnk54bQJ/91zlfU5DPv
         XVtKJyxuwoJdMIFP2CZBG2/04+Y+o/FeOGl4vzYql+4loPeVxjD8mwTjfL0Rjpw19L6X
         hBIw==
X-Forwarded-Encrypted: i=1; AKwUvBx4/fXdHIdtBDqBC3REwjHdN358iRTiE9yxRndUp9Gx4M1lZWzwlEN5/sGg7LQogF9Z+3A=@vger.kernel.org
X-Gm-Message-State: AFuF++nWWDqAn+4OId7CQ6lQ8rRodnWJqLMmFJ03ihiMF5SsWKksCngv
	gIupoXcuSIjM5c/1iRgukSUqIIT6RzQrDyxXIz3h5t+lhP0f0W8NAZ+fjMk+rDehUMbLWCs3sI9
	9d8SuomTeLzOGw10iI3RmP/9bOJw0ygE=
X-Gm-Gg: AYBFou3WpTViOw8GXH5ZilMRGvlZzGLiYZwsK2RoWL6IZvVpsORLqwuaBL5h72u81tA
	DcIDwLZyc1jznjtpjodKDz5EQjno+rdPs8paz3Y0wwrmT+ZIkItmzWVkf80M9soKC7lpFIbn7R1
	q7q9UmLB6eVOlJwI9wevTdgX9idtErVsqieDBD5EEY+oC+MDwktngG71rgCxd8CI6V1ba0Y8SV8
	qpWVWs+8YVidNG+x3ZoALa+SDTHZM6jnNpwIzZ8pRfJ7yQvlFW8zi61a0i4/2U3d4hIk9r/75AB
	TQizN972CVFysO98mu/lXSYPoT5H18GtyiT0RsW0ApzVgcMKiHjQIGNW
X-Received: by 2002:a05:622a:1102:b0:530:d429:c70a with SMTP id
 d75a77b69052e-53374a9f0e5mr71073341cf.26.1790835280875; Wed, 30 Sep 2026
 23:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914115607.350097-1-imbigking12@gmail.com>
 <c28917c2-4715-4c70-a2d3-582ca641e1d6@huawei.com> <CAADnVQLGWcdi+G-cWkxLCtY-Q3iQ4TJKPcL4i35+c2e_snSUWg@mail.gmail.com>
In-Reply-To: <CAADnVQLGWcdi+G-cWkxLCtY-Q3iQ4TJKPcL4i35+c2e_snSUWg@mail.gmail.com>
From: =?UTF-8?B?Um9nZXLmtKrlgYnmjbc=?= <imbigking12@gmail.com>
Date: Thu, 1 Oct 2026 14:14:29 +0800
X-Gm-Features: AclHuK9sgnNLOPWv1o9b11spZv6pvIUx-GPm4pSYUHjOL1ryJGDiBjLKXIrglqc
Message-ID: <CAN2uUdme+EnpG0w2vD=kxWzDxb3ik9PDwZmV_Na-sVCC-HVOCg@mail.gmail.com>
Subject: Re: [PATCH] riscv: patch: fix handling of bpf-jit execmem addresses
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Pu Lehui <pulehui@huawei.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mike Rapoport <rppt@kernel.org>, Xiaofeng Yuan <xiaofengmian@163.com>, 
	Klara Modin <klara@kasm.eu>, linux-riscv <linux-riscv@lists.infradead.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 25, 2026 at 5:48 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Not clear what tree this patch suppose to go to.
> If it's bpf-next then pls respin with correct subj,

It's not bpf-next -- this is a riscv patch for the riscv tree, based on
riscv/fixes (b94cec5761d2). It only touches arch/riscv/kernel/patch.c,
and the "riscv: patch:" prefix matches both the file name and the
previous fix to the same function, commit 8718e5a3090b ("riscv: patch:
skip fixmap mapping when kernel text is already writable").

bpf@vger.kernel.org is Cc'd because the breakage manifests in the BPF
JIT -- bpf_arch_text_copy() fails and no program is ever JITed -- not
because it should go through a BPF tree. Sorry for the noise in the BPF
queue.

If a respin is wanted for any other reason, I'll carry Pu Lehui's tags.

Thanks,
Wei-Jie
