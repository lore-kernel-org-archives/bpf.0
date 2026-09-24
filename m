Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF741BA69
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277582; cv=none; b=p2gaYUx5fCGuXEHYvFDjY90AMkozAOWasS42WvBNa5XflgvepTt50nTU/p7QXZ8m4RW7DIRvKmfk3C0QwOBM/Muw8fsPXjY2C7gHjUis1BH62Jq4eKQc8iDHLwmFOq+QJTN217u9zu74ucDvyPMepMQkovbYmJDWTn7NEW3zaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277582; c=relaxed/simple;
	bh=aSeAMMRejQcvgqM/1az9gIvLK17Z1fc2LbbdhiIiGFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnQFzRMeS7UiaUhzooARod+TFyATQa47hphh6TwPL8F/ovJd4yYeVKyK8bz/aVj8f/Y1dsOVQBeSZyx3+rwCIH+EpSeHSvs1FkjYHquObDWrLjUiZ2sJtJmtPesk1Ixy8e4pNYACc371FQ1whS3/G9IEJeXtyp7HGYUoFxHhk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OX8ss0Kc; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX8ss0Kc"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so129732e87.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790277575; x=1790882375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSeAMMRejQcvgqM/1az9gIvLK17Z1fc2LbbdhiIiGFY=;
        b=OX8ss0KcfBhCZ+MDhcbpPlY3PxP9RVi6HXYo/IOx6ESm612upfZB7/NERyqDqsmmQw
         ISffEidKZ34q7Kg+oqbQbnehgw4+cdK9NxbBPANndL+cKm5tj66Xb+HfnTK2H8qnQaUe
         Vy+FHmAhmfpGETlTTcDZRrfbOYgEM2gaqZSUbO0MSYrzedzs2scrd3xjaiskApgshhoi
         5HVP929BybKib4w6KfdjInoz6mk0RBi+D2Y2s0kEHfVJmBrfrpqxw+1/JjknAnNeSKeK
         D+uVko46iJ9TNe8Lpa51QJkoMiFGGwbD4bZb2KQr4QZLy9vdSawugTmoYgJLWlAgCF4f
         ZXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277575; x=1790882375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aSeAMMRejQcvgqM/1az9gIvLK17Z1fc2LbbdhiIiGFY=;
        b=2pm0gqHFDnvLdK6jENXmmTC9m8pvrWrXN1T6T4Qw+IQ9gOUly46r3WfGsLOjxxCSzs
         H5QGras8YBMfayuDdoqQYSYOsyC+o1s9rMWmGzQ+QLwGlbgV6WSW3OFB0qP8ZErUSZQO
         805BAAcy/aqShCl2uH8IWgWi2SOBFUekl+nYoDXLydpoxRObKiE/1yc+PyGJsGaX3w38
         vDKvUJV1SKFjRsXxh50vFDmgdlhTVDLLRjgUrgeWneydcT9lsrKEzo6R+nMexYK9PuP3
         bAIrSC49+yICmcbkQqaj7Z1dR8+4SzfB/eu5zMKugQsIdEiYaNk69mf56ykSFXssQG5g
         63PA==
X-Forwarded-Encrypted: i=1; AKwUvBzU+b8sr8MviXV/+/E+Ui4IyopOXf49mlwHyDEXocx0AWT1r/mPHOraL2WShl/X1RD8WYs=@vger.kernel.org
X-Gm-Message-State: AFuF++nJF186HmXUDIDPTJGGbqwtfCHFniv60DlF1SADUANFr3M6SkW4
	QCqK2RpjvrwreuUF44Hwui8ZXMKr3FmsPAciOoYggopyP49D0sAsZ1/c
X-Gm-Gg: AYBFou347z4Ei32ve/NA8iEWdBx4PBmfq/cBFxtTB9O1b7JhdB0L+BMp74Syph6CyLO
	3KR/97f8wpvetDonqayBdprFc1KEJWzE6lShlA/FsVl7EIMMWSSdIFMmt4w1JsvBP7fzcwboqQT
	Rx0gokkBQdm/wbyAxXfTOUL4/i1YK/RE0883j6joGSlhK2SUwZFmTXERQLrLWtNU9WyKch8CElO
	hKdKKZio9rqeWouQBlnQP8z9JQpTXlO0Sv8aelXgtR2pzkFO/8iC65pG9JFu9BlUCnD/+3zUhQe
	/rL0Uo1ON0+j6Rn+0S30IdrDv1j0i54HjoZPxmElSfKDZ43a6CI5MWlVDIzp10Q8yhOidloGQQP
	ZHJdbilMYUSnskDQgPx5DAspRJVMAzIklmkF4magHVxnaeLM0Vk9excgM/OecYEzODQuio82D+g
	judfyd8co6JgrwWqLhIEXMXBpSCJfYWlvJEVIKwGlHdFcThSPegMWLUbGVog5ROS1mcaX268vyu
	VkEDEBBIZCtUUMv
X-Received: by 2002:ac2:5ed1:0:b0:5b8:da5a:937c with SMTP id 2adb3069b0e04-5b8df0db9c3mr928965e87.17.1790277574572;
        Thu, 24 Sep 2026 12:19:34 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.131])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a64c3274fdsm47331fa.38.2026.09.24.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:19:33 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check that bpftool reports a map it can't dump
Date: Thu, 24 Sep 2026 22:18:36 +0300
Message-ID: <20260924191912.548272-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924161724.E8D501F000FF@smtp.kernel.org>
References: <20260924160732.485650-1-skokovmaksimevg@gmail.com> <20260924160732.485650-3-skokovmaksimevg@gmail.com> <20260924161724.E8D501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Should output be zero-initialized, or should the test verify that output was
> actually populated before checking its contents?

Right. v2 clears the buffer before each bpftool run. That also covers a
second case: the plain run reused the buffer after the JSON run, whose
output holds the same message, so a plain run that failed to start would
have matched stale output.
