Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D68322A1F
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113003; cv=none; b=YFtslis4E99v2ouFC5+yXplDx52WtL5JkK1JrFtsr13htkH+25GtK147Nk6A+jjL/x7foqP7LRd+5sUVZ1cZYZhvBmjaQ21DWCB+NOoNhe0+n9k7sB/Yq/g3RVIJCU8Ce6YEFNoLSFgRkiOzUDAYKXjzgqz06ukI0q/751pOL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113003; c=relaxed/simple;
	bh=jUUm2iRYcjaZSF2K8MfCBUO9E0Vvnx4q1k+mEDTtDl8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=BT1mcMlm5+MlyrpTkylbaWK0XP0Z2/REhx3ontHbI46ymyHjsE3jSukUuUY4N7F/PlJm9n7we65Q+KeavugWrqwdVyUK5QA4thfeclh3SDYnCTEEy4hlPZK8h4QIfOtmWWC2E8Yvf8Ehu28gTJjSNvFcSOyY0tdsQVpOt/4hvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erOkb++w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erOkb++w"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so35259975ad.3
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113001; x=1792717801; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUUm2iRYcjaZSF2K8MfCBUO9E0Vvnx4q1k+mEDTtDl8=;
        b=erOkb++wQfVlODqLraUkIlPMtsDwqowUaVL5uWizK8+sgL+qvQpjq3OfRDiRhgU8lr
         1k63YjYF9jkAo0Qe5kJgm5u81ar0LjC1C2PLW/HUO2ne54xR1oBKRyilHusFwS/9bQ/r
         fEFfrOrA2Tfg7aZQDASQF7CW3whPt9PwxVk7xQqtekILqoHMJq5SsIs9mQlOzAXPJQFw
         G9qTJrqFYvx29DG9QLU/O5/egRrB1ZLNp9WvRvS0S6AYk2dX+QQD69K6CH8gLY2UQ29s
         gQSg5ksj9YcEyVAFHSFNLnGhrUII0K5tsukUljR9P/hQo8bbgmZ4Kmf8PBM1VpxjrPme
         92zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113001; x=1792717801;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUUm2iRYcjaZSF2K8MfCBUO9E0Vvnx4q1k+mEDTtDl8=;
        b=y72KMgvM5S0N+WTr9Gdw6uf682du4s9sUPwFx2k/ChIjlTaHHf9oKtvgrFrkQFBjzD
         M/UwfqFTb0I0mQRJ2YofKJpTvFWjHNyjqgBq2wSWiFmMgBGCgcBQSAlAVAGFqxWAdDMd
         S1nrsmffln4fhjnuEZCGF2N3DyLG683fYHFN04f59VZFaSIIeF3025tYGfPhDYW+3hy4
         ztjdwTtpdhvWBSwFDTv1/KaXNAfMq+2l4B3uB52ur1cD9Pd7gaceC70oAIpe/nYLhI+6
         V9xdbsoVSceHF/epFrMEGdRxkVEcssWPNzkE1nt1cOZAxAKUhq3MnHph5pmCwsTWIL7E
         S9aw==
X-Forwarded-Encrypted: i=1; AKwUvBw2qqXdOQSD/o0EE0mEoSQsvfz7Lvi8n6+/RmAGlz5HFAjsgZiPix6TRJ2lkcXoomTNaq4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQ+tLjdzD8hyQUTGvYtk6s5wXkgnm64fABZVLz/rqq1JJIb6m5
	Jp2LuEXaifTcHRC2AWTGGOu6AekQkxu0StVh7FFCeqCBuQJ4DNj2Lebv
X-Gm-Gg: AYBFou1fOvYOIyFoOTTaWdWT2saEnlg8TO/jMW89V4R5N7ELrWbR6jl1KovYw7jFdpb
	G+pg5j/5yH3gS2Gru9Hqgm2W/BJm4sSpoqjWfmW6HFph3cUkKVTeE7EuHXmNK/+FOhC4fnoF25I
	b5Va5C2aqob99CbnIvWLBHxrznU+HbzCPqdOeq8+E0OzACJZK2m1WTeWc8AqqV/1/C6WUwlrxnU
	2w2ybTiHFgBQkn9oZjkAiTqJk6eCbzg7XORwbf+vRyl21yt/qeTJb+p9CV4oJZWK4y0QwQnldLb
	yHXNABU735HzVPJkmj6DIIpVti0ISassnAl2kb/e8ETW8zcuGfxOJMvQBPPFhiUZqmRfJ2Ask9q
	KRR+52yGFVV4X8t3lpJI6OlwVtTmcl7W2lNlbsXIMWxOtwhXBC7YsTyV75zJNGO3w03yBBTxrOF
	zR3BfFI3VeePzWS2UmOLQfTdKZkL0+t5D0yuLnPO0YRmfWQ8RMixZ8Fd+7kkaf/aeMdOqOLHTLX
	wDRrwAsH7d8Tt3jn61EcgH/HGVU0XsjIYvxr+z8XpCetRc52t6dWx7XB691kard2zcEugq2Chhc
	G4U=
X-Received: by 2002:a17:902:cec2:b0:2e8:2f95:764d with SMTP id d9443c01a7336-2e842dfd299mr187176415ad.59.1792113000672;
        Thu, 15 Oct 2026 18:10:00 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d4e51sm2604795ad.1.2026.10.15.18.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:10:00 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:09:59 +0000
Message-Id: <DM5V1EIGVJEG.1IIPS4R40HPA0@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261015234125.3152346-7-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com> <20261015234125.3152346-7-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 01:41 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> it on, as the tag says. A tagged member of an existing struct thus asks
> every program that reads it for a check, including one that reads it
> through a probed pointer and relied on a NULL dereference reading as
> zero.

Commit log reads like BTF_TYPE_SAFE_*() can go away one day,
but with this change adding __nullable to a member of task_struct
breaks every tracing prog that walks through it without a check.
So the tag cannot be added to existing structs and
BTF_TYPE_SAFE_*_OR_NULL lists are here to stay, right?

