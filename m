Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75744189D7
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296622; cv=pass; b=r47BwOeZT1xmXKbLp+dvR8ueTvvn9QU1N77+j2JinkrLxyxiAnX2Tia1GKe79tKiZ1tOQi0POZz3TpPRjfSDTxwozvWk/eDT42zslqvBnhj7NyvzgHkDHrEQZgj0nDR0X+2mP5dkMmJPRqQ5ybkFsygYYIdguwG2j+86Nh0RJqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296622; c=relaxed/simple;
	bh=SRMqGUm1r3Dm6PkdgLJsaaU5vrKGbkGjLiZ6byEAo1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkzyHcVRewVIpDWSmWLG9YxVoyrDw7avoFU2xZgT9WcnFgDTu3MsAuGYitbfeojJ3+KTFAnam42mmfN4+D53iAo2aEGKtTsL4BkALUGRS19MZvvAuhEkr6PtlRvvILgbdMIE913Qkf3HdJSmlzr3X77ySk0LSSMCXNC+vAF64gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcOUr7cn; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcOUr7cn"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so5939109e87.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 06:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296619; cv=none;
        d=google.com; s=arc-20260327;
        b=KCol8P4paCTrIyKzK8UuhswF4l4IKYY/qqh0Hvwj+3kF+GS7S1yA81Z10raO737EwJ
         DExiRG+srtnKSMDZDLJFhIZUslvFIRuZzZktltciNqGZBi6YcsHgCQ8UH98h10WW+LZw
         LDxGF8JHfcunVL1ebOuKQ1U6zSgq67s+2BgOksyLBnJ/BcrkFh0UwclsjrHDAJUYlcvW
         NWRd8eibnuoJf7WWYS04M1VEADGZI0dYICp2ABsUpBOmBGHjg9ebrTSFvC2jWC4EmUQk
         edLGT9cIBCVh/tHfhRLE/EtHJpStbN8eWMN/qHKsIOf25zLRB3tB1GFamY4/cRqAnTl0
         ai2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SRMqGUm1r3Dm6PkdgLJsaaU5vrKGbkGjLiZ6byEAo1w=;
        fh=x8LOQdHgEyilDg3Y7uP+LF0HTCWBqz2wOh5en8ab960=;
        b=d1GoaViXKqJch3B8K/e7W2LSRqWq87Wf5SvLSW04Fcp2qFOYaM+/dtOqmFXCH2Hxgs
         u6lVf7THFhiCEZLJnxaMYnhOgdenS9kkB9IQ2ULPA+rHajySF/3Nxl9NpxEr3g+HySEk
         7A1bSm9dr3YB1qib35PmBx28o+XWcQAlJkmuk6a35GLjXEnzNyn68tIhpb8Pa/YmeeSV
         +8WHzPydc4meDBTojPCZKrDa4xFAkLUPcsivMuFuK2QRpKXIRiel4Dl+3b6xhGvStDhf
         gKDyL64HCLTDKX4WKS5i0HyC/p43jm/cqbFC8oz6zE7TNYU8qtMWwCIEn8A3PAMiaf3E
         ASXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296619; x=1784901419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SRMqGUm1r3Dm6PkdgLJsaaU5vrKGbkGjLiZ6byEAo1w=;
        b=QcOUr7cnMAXCFjFOAZNWPE2m3GqXDerOJOllerrwST9uZBFQht1qPCZ7uSC9sa3Y9j
         /rQnDtUj9tUdORh1VBt29PPtUKflTGiWF12d5+likhOZ+tXR0cLgLxdBr9bZzoEo/NnA
         Y9BsE3oOJL6dkzcBYdXJhHjNJntlRoDBYLQJAEejiSqVgZ5b09of5QxIqb6NsIkBPMDn
         umBA4GfcL2LQqBxGei3iLgMerckQaxVPUwbgmVN0UrlC8uXyF581cs39n9xeriQ5xWDL
         u5Ub26J6GMzzE+8vmiPdZxvcIxPZYchCgjBvW0G6e722F+GaBpD6rhjUJmJi3YLXyfpI
         xPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296619; x=1784901419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRMqGUm1r3Dm6PkdgLJsaaU5vrKGbkGjLiZ6byEAo1w=;
        b=Z2A5qoJJvUcrGE6572epjQwIEst5px5qTdkpSVeivmKeoI+jhNmgUbtiVDDzZ/S8WI
         3amfXlDx/sfqeTxtymlDQEn63RZ3yL8NkSW9iprlkfLgHb6/eMmi1RXW0WrEoC1Qa08Y
         h09Tjjv2VTb8wexsRRqKXLZuJkJVh/dilfSU5KBntOAgNW+vSIwLmEJLt5gQIsh1ICRx
         p66bPVQTOIJ2oqKw0sVsBatt6FVsXx58u52Tc5w5NNvZ75X9LXytdMTG04gqS6LGUQfq
         iHxtDYlVuuy8jpUIdYIaSw7WeJow+bUuA//PxAUeoRhCOvCwCjV8Yi+r/cLhb2/KvWt9
         3CTw==
X-Forwarded-Encrypted: i=1; AHgh+Rqzs6YtZEeJlSYhkX9LFAT6cMO/6LYbsp8v/I+5kZDBmSXFoF/SLil8B9qJ9Lk2tRXwsaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jWkZxb6YIsZ3TdRXeaFk7WxMKS+mCxuSRYli2BZw0aopkSoV
	5yLLxDOjv/rSiWldlRawvpoJNOhUtLcks/0GvBb8rRvUMpQKYSYAUkS6Df4kv5ig9C46dB0hx0x
	dnQ5HWC9Z2mO1RlXoUQ+V4NfnVHswu9A=
X-Gm-Gg: AfdE7cmUNWsVIQHYwHHRECqa81VcSRuXoBEnR++amOTQwktIg5tjyOHfUei8uT6nO+Z
	W9nIUoFSZJSFGbwXV02BmAfYTLDpIe4PeXPuTMt6joEMuI/03+Ch31xS20j4Be8fkxTsCvLL3at
	4nkzqZiUbX2f3yUQlJL+NhiJ/qNXZF0geI3g4X3GYsggDGKPgD5XWBHa3SRJQQ5k1wI2nv8HNZ1
	qLS2L83IEMTnxnZvh6ljX1Vl8GAzpSdNkh2oAej5SdM1+7IUm07MZr4eRd7SzyvKy6g/pyjEB9X
	OyXmFCmyd2ZP76PdxaCHbkcuMYY2j9pQBd0hnraGyPdotAqsq6WgeilfwzszMoqmg3RyTkKmV+d
	b
X-Received: by 2002:a05:6512:3e10:b0:5ae:c5b2:9cac with SMTP id
 2adb3069b0e04-5b28f9991fdmr723642e87.33.1784296618722; Fri, 17 Jul 2026
 06:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <20260714140722.111645-7-maciej.fijalkowski@intel.com>
In-Reply-To: <20260714140722.111645-7-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 17 Jul 2026 15:56:20 +0200
X-Gm-Features: AUfX_mzBMeJfWc4hl-RU3D15yr8ZFgtlPUig9TueSwyy2LlqRRDEQzNxFo2tOvg
Message-ID: <CAL+tcoD3YFjedWWWRCxN+3R5w8_yyQCiEd24Qo=L0_TbknQebg@mail.gmail.com>
Subject: Re: [PATCH v3 net 6/6] selftests/xsk: account invalid multi-buffer Tx descriptors
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Invalid descriptors in the middle of a multi-buffer packet still belong
> to the packet being consumed from the Tx ring. The tests should therefore
> count the whole invalid packet as outstanding in verbatim mode, even
> though the packet must not be expected on the Rx side.
>
> Make fragment counting follow the packet boundary instead of stopping at
> the first invalid fragment. Update custom stream generation so invalid
> middle fragments terminate the generated Rx packet while Tx accounting
> still covers all descriptors consumed from the invalid multi-buffer
> packet.
>
> Also add explicit end fragments after invalid middle descriptors. This
> exercises the kernel drain logic and verifies that subsequent valid
> packets are not interpreted as continuations of the invalid packet.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>]

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
