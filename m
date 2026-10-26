Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058354;
	b=ey1b6AKzoeSUFM/ooUDLGL2qShi6sGzjUPbOKGaIrVWE39xkH3dQ/c5pq6Vhtic78mQD
	 6vY0tng00JfMrHDgLedMFA3FTK08hI/rCtIHKlO3R1OMgw3jXYBbfCnlbjAi9ODbg2lR6
	 MO5uR64v2gZ9AyLD+CK8BDXdABEDymQ8rVu/S6Lm3nnxSBIEvnVJ+EPB5Rob4yg5T7Rn2
	 hymO7y2T64AyXu+6HmMd2wX2Qo5lD+8Iue9VrTu2rBWPgOWGxDDnXYj/lq82rQiCegQeE
	 PZD7Ng+wWgewaZMEoWD4NfQ+Xgat2prBH9lQoCzwADq3QNbjIj10X/ebKyGN/+XpPyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=ptlN1Q7T2eFuXsNou2B7bC3CUCLG3upiARkYrF40Fcs=;
	b=wPHybCZTPhldamoEKX7CoEEBAyUvXh+Gto37GXNgxIhG1L5RU3obToslHmslSP3EjmSY
	 xiorvYnF6OfMmdpw/h6igZ4L6HM3zwy5M8qdsnz0cTHm5GAHp0UXrOAnvBcf9zzhpD0MA
	 H3hGZNYkPtOXuRErMywrdu0pJlMQe2iM23e0EcMBNjosDP2D2a6Y9IWfDKnuaP+P+K0Zr
	 5Sc2QZhUX1qtNc10QycXeaIV6SrEid7RFoZJNL5wXChFZp+ri1rag/YPwqB9z79RrUWdV
	 cOKca9YNOdz8XLcFJDuhi5Yz9sLSrRiJ1Cq6+DqKlISBOBH/6WdkDlJ768dHpV+J/kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kz5Edxvl;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16643606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16643606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kz5Edxvl
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso1275430a12.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793058353; x=1793663153; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ptlN1Q7T2eFuXsNou2B7bC3CUCLG3upiARkYrF40Fcs=;
        b=kz5EdxvlTEiIUR46TLDPpiiwB8+6q7skaXt4GnzCal/PNkpJAPP+ORgQcSqM/xk2Wu
         43PDj8QRBfOYIDlNepzDB5Iwh4pYNM9whicBPAAHtSiPUIbrPNG+XLYG9/eH4hqDH5Jv
         FsynZHTnpoRG4O90BHIYpguO4GTfrTQs5MMpLtE9kXfCuZQixgYBCU/iPASaKZjH58wk
         TpgkFvPPjZCgoYDoytENR985HPKLP25TIFx72psQEIZBQ44V66BT0X0iTl3tnyizC4qZ
         6bk+zoa34a2pyZ6+Onbhw6J2KYDDrcqC0L73/CaN9J8RezqWlv5Uj/p/TEKuzMTo7fGi
         4LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058353; x=1793663153;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptlN1Q7T2eFuXsNou2B7bC3CUCLG3upiARkYrF40Fcs=;
        b=ZW7vxanw3+ekW+gpu9+YaGc4AUE0yBrhBG3d86f5HRBGr1VPhfEcWHbsTBYRh2PWdN
         cVEFD5ctAbXOBTmAlZkrWpcCpe/fDKZsx4KJh5grvhFwhnDMG6imPXw7/+H6wJzN31vW
         JxTjJUPq9mpGe92674vilLsq/A0lrf69lYOixFGY/Nv/7LTJjhLY67Prwa0tkCzTb5+r
         GKDqdGl6+M96CPJcP0ZAR9+EI7GAC+7dq2vCWonf4YgrXAlLZuBKW456H/P1WTN5cIQO
         9QgDnvgEdYxKWCvVV8M0wIVvnqbwf8VR3lSj/I4lPv17wBRhHxWnMOA6X9hBFp4Jr6ZG
         /4qg==
X-Forwarded-Encrypted: i=1; AKwUvBxybU8pM8SQaCEPCXPVpwiCbXrhPYPZ9/D1X9irX4u6y6GnhFQWek0mJsMbFV9IBdc0yZs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6ODt8R21hjVpBu7De7b16nJDxv+G5wbLxkQws70rYCByWGqGs
	Nvr+5so3LLWPkGFX7YO8ifsAeosdzuvdwhUmpjPFnoEqw8VTjCDqpcrg4dMcPQ==
X-Gm-Gg: AYBFou3h99NV/2PCVB+mxhY5Ix/VDm8W7ZvPNjfRiwTxwA8vMmjbmm+KNwRWv/KrOqR
	LrtQfJ6lbji/t/soaect9k4uUYQGsv1uTShGGCSquSQCeaY/Hi1hEnNsDP0uicyl/9ADy0r38V/
	F+xCtS9qWbcDH4KsQqNYyD2l+jKxGLCz+47sHx+Pmf9imHC/9GESIxYT/QdM2v3uJwHjSE8Ifn4
	hl1AlEnvJHYwDzQizTAyQXYKSWYvo75TfOWpmoLBF/l0x7pYgWho/PMv8h4uUZHK8EoYnS1Mhqo
	qzlDbOqHZhfdWcsO6sgUCipVFyNyR8uM6DY9qpWhcSNHKV5J32lDWoWPPBCofDDzU+gvvtplK0i
	r+OtiaZoZzvqwHMpuc0GRwUGnaab61kNmG8XZhjo2T2T2DjgoMaKISWSlOmqVH8QvPGWerRK5LF
	oJ180Q4ZseOaV3x8+c7txRkY6YT1y+COMQdDaTB6BVmk5RjRkoPSV2Ld22bRj6atAHumf30iA8T
	rC8YHXxGAR02/GOyqVsUUUMeRnks5pVlTU/BjUZxIWBM2cxyoPWX8bFKEY4K/7loqaM3YNXL1t5
	khlMLz3v+FbOhEml/599IOIPAEG5mTKctXGPgW/g/6y6pP2CTtHa2oQosLNDA71cZCFWbEjL999
	gMiOr8ZWb+SQuZUbpgOu6IROWBdeh6CSrfhU=
X-Received: by 2002:a17:90b:3b41:b0:3ac:7c52:fb04 with SMTP id 98e67ed59e1d1-3adeae7b8f9mr6887469a91.44.1793058353349;
        Mon, 26 Oct 2026 16:45:53 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40427bf1sm1204198a91.6.2026.10.26.16.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 16:45:52 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 23:45:52 +0000
Message-Id: <DMF64ZG294VY.LCU9YQI054U2@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Subject: Re: [PATCH bpf 00/81] bpf: Stack in arena and a verifier that joins
 states
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <fbb26ce0-00a0-42ba-abc6-82c3c6201d8a@linux.dev>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <fbb26ce0-00a0-42ba-abc6-82c3c6201d8a@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 26, 2026 at 03:28 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> This series shouldn't land as is. It's not ready.

your bot didn't read the cover letter :(
that said that parts 2 and 3 were posted for review only
Only Part 1 is for landing, but parts 2 and 3 depend on it.

>    * ask your development bots to ensure that verification of prod BPF
>      programs (bots can pull those tested by BPF CI from github
>      artifacts, just ask) has not regressed, and that there is a path
>      for updating existing programs to work both with old and new
>      verifier

your bot is wrong again. meta progs are not public.
So test on meta progs the whole set had to go as a whole.
