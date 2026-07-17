Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF88418A24
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296608; cv=pass; b=UNgLWmT5HAD2442BEhlUfzUKOfM+hXQzuSdA2l++PaU5oB8NANgMM89XxMVPKbCDb1aiAYsgCCjBXzoHioNexkdcgRwG2QhEp3GHZ6eEDGiphNTOjmn8p4ptNYYcdfHD39IUZ8xXKjRrx4nCIEqRrnp1pKn1EH1Hze9pea4LW0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296608; c=relaxed/simple;
	bh=ErvyfkwfekuvkUJ0WW3upoWBqOO+tdHfRz+KHfX7g8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdS7cPrKe3XiRifoH6oAtQHxTLP5ZqlL1VOcv7FKkWWyJyax5sVYi5Fmy1Uml2gIhDfavfxa1mu38UiYnNND8cl03ddijkXRnHizXQXuiQOY/Sb2lx6sa2hTWWqK0k/5yzGdPRzMXDzsLIcIOtnF5gymac+wAPgbZAPnHjn2fiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJZdjMEZ; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJZdjMEZ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c74722e27so20244381fa.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 06:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296604; cv=none;
        d=google.com; s=arc-20260327;
        b=NffHpcmZRVbBTGQDzq2TygtdrHp4+IByLAln19W2o45zUTl9CS3c0X2Mk/1YVCprCX
         RSNEw8gy4QzOd9qyOtY0O0ZAAYGEKtn/xqEceUSvBMyAP24yyqRResozv1oRYWxaF+Sm
         5qdMt8offG+PIwfxVwEngQfhDOcQiO6/PJPTIBASZ5p/HNZL9Cg4E3YLFSoKgwbFC2Ky
         QcSI0R1VGd+As6McR9mORyiX24hP2wmvYYs8VMdeEcbWJ/wFrNCApWPhQSY8sO8i1ato
         L3su+VBs3LUjjeAJ1OSf0qgOPSTM0ER0qvIea56RGDcNI9BqwAMve501HjNBGRtIjAbe
         OiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ErvyfkwfekuvkUJ0WW3upoWBqOO+tdHfRz+KHfX7g8E=;
        fh=3HwBrKJt9GXfFXiGJMY+cRE237c0AlB/ozzg8gqYEGk=;
        b=idvhN0VROEDLbVj5SzUpXMu2sNlfXv0XYpLVY31AZiutMxyH8YexYI0GJwAlIQ3dAq
         Qr7TA2fZ1J1ZOjgpjA7LF5mot/s35yDdXF/r+0B9TclU598CexFSDxmjF9HAJKKXU7zi
         7AR2osLPXTd0XMbzUx0wueW00rjtEhqfQ2fdjiSJxAH39jUKJEeC21k1o/YW0S2SqkOB
         mbsh2Iu9qBmQ6w9oRjcpIIBj4hfp5chy0IoLJYRAgLfLJPcz+HvNIubl75hXAKASh1go
         DkR1kPgCrkX4fJ3X+jLjI0sLJnk93+Gr/e5lJKPCFVdEqrq8deur/SWvpH5kN7NR+nJI
         356w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296604; x=1784901404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ErvyfkwfekuvkUJ0WW3upoWBqOO+tdHfRz+KHfX7g8E=;
        b=kJZdjMEZtlIN+5CvZD9TiW7lcN8dI9iwlAvPRDjj2SuTHAzOPQ8ovdaOh5/ONvGQSg
         9TQGYKj5IB5/Dyu/MI1L9URCAiVevQ4O3O24MsU65xjxpB1buzlrmgb0x5vog+vwzL41
         ca0XD6usio+KqT7ofVZ0rwnOfSHbh+DWj1HWNBeZ+liNWpXua+Iz6njE2LpwWP2nxLXz
         MP8LCMQ+v7cWiwF1lD2/Ao3YaGAMbeC3P+GAgFCWR9IK6EnMjSCxlmVza+zT+Jr8YHT+
         BupbLF7oM6/rnx58ZpX2IxJAHCDXyWsbMielAjPxsLGJuN3uL+yM8qfypK0q9cCO26OQ
         8eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296604; x=1784901404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ErvyfkwfekuvkUJ0WW3upoWBqOO+tdHfRz+KHfX7g8E=;
        b=XRN324Vy3F8ey9fTyLaZObKTf27sL8+FPj7wrCObVmtNPG8UISdUBFa4QwDNmvIoIr
         cXJ98GOpTZOm4ihjDO+rdvboVpQgjQZ9BOz9DMMlGng04JJ7XNZuflvFkRUU8moTgSu9
         fY1lPemgRx6rcZoB28onJwoC4oxlnmar3+AMR4Q7WHe4fEpVMMeYyb3I4m+E9qFuEJ4S
         xV48Q1Hm7FFnRg1rnJvGQGqeroSGQqCNnWj6CdcgXQQieBVnH7lktnqQ2U3/J/oK14pG
         2fQ6u75GMTWiqZVOtHviqx7L0hyzLRTklurim28vsy7Kat75YKCiN3MuR/Uq+q7VGbf2
         JUVA==
X-Forwarded-Encrypted: i=1; AHgh+RoSU4YTHrM80t5zv0Z1SS6slq13QKuV1wqf75VrNAqVPh3vYFBo6M5kzvT/yUyQkjFhIqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs14lqI6vskp1kQfYaBjIrkhpp1txAW6/96H8sZ7qp40ojHWvy
	xVWhSnZ1yP5yFSgy3vjKtcXP2yj14Qh0f3tubxUNqoKv+kgJIqr2Hf2Ci6dh5f9Ui/oVaC2LALm
	Etfbxo8caHEsunMROCP2tnSuQQkQTZZE=
X-Gm-Gg: AfdE7cmqg0SuuN9UYgAjtCQPHlOLd9PHdVEnZz/TPh3T7NVVvXXtkGW0hiMVR/dZLuG
	7y4Mvif8JvrhIxAa/9aharongXhBsHGL7wkh3nvJNfPQH4k5qxcjYNC3/Q9zFVm90cRdxi2PKSJ
	1Y8nia24uKqPgyl+9nTV5iZIgPqbBUtcQEChWlGcc8ZBVbF5acY8TD2ppybjz7E3B6oFjfxpC6t
	3oPxztQONheM8KUM+vzdChOM397AHqzFj1HgUaQzhDrUWvGoJdS7j8FaeBBbYIU7O5Zk6uzCRuH
	ANP+wdM10DCZBf12csZTy1CLvF2EIiTV/RykImbxSUKcscB/guidvGQ+D7DeWZQu7tuBzqH976d
	6mEqqeKcuUrVvcNPrNsxBzg==
X-Received: by 2002:a2e:9584:0:b0:39c:a0a2:fe70 with SMTP id
 38308e7fff4ca-39e9fe04a88mr8262121fa.8.1784296604244; Fri, 17 Jul 2026
 06:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <20260714140722.111645-6-maciej.fijalkowski@intel.com>
In-Reply-To: <20260714140722.111645-6-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 17 Jul 2026 15:56:04 +0200
X-Gm-Features: AUfX_mz82S5i-jqJDTI8fVjpB6bjNQ3HZ8tw-PF3v6beC2MyccVw3Ymh1QUuMas
Message-ID: <CAL+tcoBsV4T0adG7DWpzVoMij8o707HMGp9w1f_g-Ot5qKhrfg@mail.gmail.com>
Subject: Re: [PATCH v3 net 5/6] selftests/xsk: fix too-many-frags multi-buffer
 Tx test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> The too-many-frags test describes a packet that is valid from the Tx
> ring ownership point of view, but invalid for transmission because it
> exceeds the supported number of fragments.
>
> Keep the generated Tx descriptors valid so that __send_pkts() accounts
> them as outstanding descriptors that must be reclaimed through the CQ.
> Then mark the corresponding Rx packet invalid so the test still does
> not expect the oversized packet to appear on the receive side.
>
> Add a valid synchronization packet after the oversized packet so the
> test can verify that the Tx path drains the bad packet and resumes at
> the next packet boundary.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
