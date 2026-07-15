Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE8441635
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111243; cv=pass; b=DQbW0WANGiBPDydptgmG2cbZz+fjO1QTcecIYtoBDVnI8qh0PtIPUd12gRZOPmmVkEb4Uez+H7SIkQabgCqQVByr6NMGRCyf5qpgyPOCUHT4cwuioPcOtOWllQhTwa3uVtKh+uxz3aZkp/9HivkxIaoYaAOhL4IsnSJhCr+ZaC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111243; c=relaxed/simple;
	bh=Ye/9u/kfw2ldB2HnBfjL0BYaRgTTNbK1gZ0f7JtbS1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpdvF9vGrV7nk/miv1i8HHhIWiTEd+rpq51FhV4m6Hv4iiZCKllq/wEly59Y6RxuhyEXoqrVxDn+gOtRx1bH7SAWacEAoICw0DUkXaeqOrTu0pRXI6AglyvZsa83uPws3yrnJ9cnJcSYZFPgXKCV1Aekym6a5V5rVKsLj0u6eVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coralogix.com; spf=pass smtp.mailfrom=coralogix.com; dkim=pass (2048-bit key) header.d=coralogix.com header.i=@coralogix.com header.b=DYlsV5vx; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coralogix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coralogix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coralogix.com header.i=@coralogix.com header.b="DYlsV5vx"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8f0d6853360so38712446d6.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 03:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784111240; cv=none;
        d=google.com; s=arc-20260327;
        b=Lbm/gSdjl7cJIuIEQUo0n65qIj+sDwaG4iV4Id7mFOzzloyST/1rE41JDqxC2X2zSH
         OJ+3oRBw3LtLRM/75trvPCtU445u+rzQNU80D4hCClwMXGkGLOIYERecepRw2I4ToKMn
         +zTW2FQ+Mg/S7b5M1pWd7/EEMXmi+x0SRhid4Uw2yFA8PI/19s7jQ5CBHxvJg6s+8STh
         cIW38EmzaL4+ve+q/CaqpW5AzE3YjFz3iBH+qidvPjfZwGNfeyrCYzOY40nPuiYXL4P2
         QPGNNgpRBCsEUM1VrwiHUQipyBRTTj9gh9RDNdT7WzZdBnPaV4rkgIgiFzQPzIRKijzX
         qbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ye/9u/kfw2ldB2HnBfjL0BYaRgTTNbK1gZ0f7JtbS1g=;
        fh=4enU/ejLZqmnYLpRuj1/MH+FHfyvuF4Fkb2UlpkIqb4=;
        b=pSmKs0qqyITsbzM7g0E4HC/zXXbu8juRT7ng2VVFoc6SnxmKpvKQf2UJ/282hwhjzw
         LUKRTwdnS6JY+fIQ5EXaQMQaAqWoJ7dq7X/6k6nMDjWc2w8fK/Pny6hE1lZ8B+C467Xw
         7R2sd2G6QC6apsnkTr3uP5Ck53I8+23Au8IDSDFEq2LbaBJsemxmeDMvM+ENpasKLVbD
         lMDiLBNoRVWNEsytrmWE34XNfJFWMvMcioEOZe64A1z18yOoK1m7BIbg6RcQCuP6yAic
         FIICKGc0tjB1HFeTehWhlQ51OcamfQAG/gOHMIJLEoFTB+ZtMSl7hfv+AoL0o3MHeshm
         ot8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coralogix.com; s=google; t=1784111240; x=1784716040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ye/9u/kfw2ldB2HnBfjL0BYaRgTTNbK1gZ0f7JtbS1g=;
        b=DYlsV5vxhraamNACv/bg0WNKu+Cx2g20r1zVVMNeWXCwFVlqlqNXMnPdkVpkbJYj2z
         YT8c31wSHIOANiZyZfwkts6FkwC6Ps7KSErz/BJ2pa0unMbgUI72djl7ZgblxNXd5f0K
         mvqsDZjuAp15DA51j3YC4Jfa9fxh9qvb44Nn5iWJ3C3CqCKYSuFIQg7jqc35y8V/I1C1
         G3lRxc8kYbslwKYjlxneZBsfxTh8K5K96yZhlY5IcuvyW5VhtjKMKUGuCWVhODwsvCQ6
         80o9W7ZDeuk64fPCvNMsVjUFqrmmsZIN9SUdNu/4on3CTGXUg20u6zTLbYFkKOyK8AL/
         RTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784111240; x=1784716040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ye/9u/kfw2ldB2HnBfjL0BYaRgTTNbK1gZ0f7JtbS1g=;
        b=TnhBZs4/rRTGi7zuntEPN0MS7vMFgh5ONvLldg6hjYysrYT85stE+zi2VfinIqZr+j
         cG/TqHIUv5SRghmXtt0QOoKbAwb3okULCl3iVp2nE6o947579uA0lovNMmXkDOnjek3p
         hN2XXVKDtGD75iOZnOA3XOyNgMOE/AAynRrKdQnqsvdbeMYD1lYHD/cC5/eH70Sbe0J/
         kmWQ+J9vWaqJ74uChYgayHfrXgNm9HSrrnOTDKxyZIiBmX2V5/BYbqfz/3oFjy/FW/4k
         l3otS3F5qI8tNZT3l4rR7juGosdo90RJgIGLUDhGMzh2oVTHOzDY0vu0RRwWlosPPIZu
         RsQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKGI59LZPaBrayV0Utbm5uKqGytO6xB8JEL4GoSjeAm5rOXkx6uNjVXgqyNvwAxPxVT0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSs0fH6EvegBAc+u1sXXlGND3w+R6ahHJffn4SZtZfp2Gl9Dw
	4vCEbxdj/kP9tvaJUH8e243rE2l0GMMFQfPOoUQf5eu6N6htx0wJzg+TS9rqCKKyg8rajncaphl
	ywdi5nLntRzryScnJIIqyCGd/T5obgE9UgV0n9xClugcYoruL8gb5HKM=
X-Gm-Gg: AfdE7ckxrQCi69sBU1Gij8Axj7XIYO3/33+mjU6LeH9J8wFrme0KRhduY3JT/d0c+eY
	rRs10N/pwuCKvgcKvEBCn4Evt65OcQB089wY2C2PYiW3BlKvtu7krRqzGO7QZhQ+LsDcoaNBOct
	RSIWc3OObKcrYGaTQ+ZrYQpAh0rYDpk9XFXXOmfvyl6DPT2mK8JxFwRkGl5p7rqGFnuj+GWQaPK
	mfWuaEw0PzfBsymAlGL1cRWcPbTv8BOM/Enw779qS2xjTXcxeMcuyyKME1FJ1WakZtiuw0mQW5z
	+bDUmEw=
X-Received: by 2002:a05:6214:5541:b0:8ef:ec2c:6b70 with SMTP id
 6a1803df08f44-9074c84cb1fmr58440516d6.53.1784111240385; Wed, 15 Jul 2026
 03:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
 <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>
 <20260708171659.8695B1F000E9@smtp.kernel.org> <alaAp3qrrn3XYd8u@john-p8>
In-Reply-To: <alaAp3qrrn3XYd8u@john-p8>
From: Mattia Meleleo <mattia.meleleo@coralogix.com>
Date: Wed, 15 Jul 2026 12:27:08 +0200
X-Gm-Features: AUfX_mx6oFAp_WKlpkqbUOQh5ytb63C69yfL4tT2SFTAbZzCUy50wCNpgxIxtDY
Message-ID: <CAOvpEWNSyn40iwJg7DRTTq0z8nFqPAFx1oakfwk06bJPssj84w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
To: John Fastabend <john.fastabend@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 8:45=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
> Sure but doesn't need to hold up this patch. Mattia would you want to
> fix this as well? Otherwise I'll put it on my list and get to it at
> some point.

I'll follow-up with the UDP fix.

Thanks for the reviews!
