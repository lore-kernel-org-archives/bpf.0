Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7D2E7185
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744348; cv=none; b=AL0wqbVLPg8xoF7A5p9zRiMXYV1k2zt3CAe40G69gBBTKQbanqkC4XSsCxW1rJJql4Z+LmmSqNW6QaQJrTbewcMLTXBvnHc9TX6LAhrkRBf4u/w/vL3mq/L8GpF+YNP0RyMIeZQgPTEYSRQ5w5zGrbVfYVKEEwc5bij/vN6Xpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744348; c=relaxed/simple;
	bh=NTpXEpa6mtIkvCkTfWXwwj33gUdCM9Kvq2+wj3uqaJw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ryiN3MqQ3JB9345I4Tz2rOmKEO3Lt+/cb8dgGm5SMCbtDDlgR4jA8uYX2/jVIpdc3A1fIu12tM99XpOzU4i60zg8Mftd82ebsKcPjAyWnGTnQVEnrUqn4ol6Fm339AGyPnVdXEns9qbeL+9rYE8opO7n6e48Txmx58HU2uFOi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTEmuwRH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTEmuwRH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so6425525ad.2
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791744347; x=1792349147; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=19JDe/f6Dzlg3wd9ErSnqDtC6rtLxIzbhuL6X3JQ0Tc=;
        b=lTEmuwRH5LQdjc9XWM4RZBWUj9l4CJEW+6oTOv7sby8TxQosYTT6EtyxPBR3FT+Fa4
         WPRtF4AjtgVIAeJEMWAFmI3Fbk7puutm+DfCsyU//YKKj8gT+uQmIPUgX/6WfRLzwHsk
         4w906W9KOCY/tcimE3FQXtmpz3z0DD2AW1NucnfR+huJcVlmRywLSpLsGH3iZudgMc89
         Dwj26jhHjtfWuXUcTIoB5Sm8IF6olf0TWeYiLN7sDtoRHs/MLvJxFWEvgQFkWS5RXKP7
         GeaJbdyKaI80rZjf4hz/a5K12RH/oJKMqo0iV2bgnzKuSf1qXRoFwF2nDasHWix6I0XY
         Z5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791744347; x=1792349147;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=19JDe/f6Dzlg3wd9ErSnqDtC6rtLxIzbhuL6X3JQ0Tc=;
        b=ShMj6cj6ZqPd6Dnjn6G8eCJ5N/SKFtJ19PTfeDW+xlXglPBhJoYvw7yIgi1Zak+SgU
         lXw5Iygicv/f9F6aQXUWh/2fbnwy+Xx+YYf5mjGlQw7K8d8JykUas3s5LK1zrQesvNPd
         PhUTTBPhE5hMnssPpx1DPkdVnPa60gnsx4gw4YniFphRjTIq6DjhnmQ5yJWh52yZPFl5
         c83GviMuGLNHkH+0zHvJixbN0EekxEn7DXZ9S7hgI5KazjHZTgH9y+kN/B9GAjp6VneC
         Gq6sGlbCERk4VBLCQobXb6i+fds+Niq4Uciw/iaJtXwL35sx6JmrkyZ+E4UCSli46xfI
         0bww==
X-Forwarded-Encrypted: i=1; AKwUvBxvT0Z5mtlQ1DsrS4c/2jGzJBezjRIOmIpvSO8VH4t6/CM1G3/oVy7qMf3wGHDuWaF6YH0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJowMka2nbENLQJEYU883qoW06LeNLbzvrIOru2SvoL3dLtpYNa
	5nXPiZfdUIdlXIes1zcAaAcBuxWiP752atQ8IVJYLD7tMtKj9Fm/btNFM7yqioBl86c=
X-Gm-Gg: AYBFou0KrK6nlZ23jjJyQxNrbpmu/w4tH+n1Omc1ApH3jCfBeLYlNAlaUaXFiRYg5GQ
	xnkO2o1NatyGGGBvhqb5l39TB2TuCFpdALOebO9RakgcR7e7ZxJS/M0Gq17vAC3qV+mX1gXfM/K
	SyBcq2sdXholDsOeRWMN5xbz22P4WWulv5pE+71umHNo7UFLNZrt1ixz/lXGKhdGcGDB0nz+b70
	r/QT6oSDYtgbqDArBwoS9p2QzSsAGfpVY93RG8klsERbPrG6QYmArA5r8p5ULAIGGsuFPo68krP
	il141D0zyA9LqQY/I0P4QrdSVm6j0skgwj41IEZSkbvly4RA4zwLZSK/MsGA2kb6WrFAQAVG5pn
	T/QwdWVZuWM2i/w3pH+a+qcrOT19a8WUzHDifPBUNvvL9n+nkhkici1G7s2vceOvU2vXLDuMs++
	69Xn7XBdwrxUJX45LjDGpb7y5O+SnlkbOYB/vCcJsp7Yga2EN58FVDVRKBePawdra2SfJHeL+5+
	wjkQ9nk339KhfraosO4rUieIOVHG9vbWhEDuDaQhrGzgafAW0qcX5f7OOhKT31pyU+vFR+/8uNL
	fyk=
X-Received: by 2002:a17:903:46c8:b0:2dd:c100:b2c8 with SMTP id d9443c01a7336-2e842ce8896mr65960775ad.51.1791744347135;
        Sun, 11 Oct 2026 11:45:47 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b298dsm33417095ad.33.2026.10.11.11.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 11:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 18:45:44 +0000
Message-Id: <DM28D0SAMO0S.1VTBTQHV699H@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <ast@kernel.org>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test tracing_multi link
 with BTF ids of the same address
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261011164836.2233874-3-alexei.starovoitov@gmail.com>
 <d51031962737267f48d83c86738616656b3024c9c7bed42330c77b3c6936cae1@mail.kernel.org>
In-Reply-To: <d51031962737267f48d83c86738616656b3024c9c7bed42330c77b3c6936cae1@mail.kernel.org>

On Sun Oct 11, 2026 at 6:15 PM UTC, bot+bpf-ci wrote:
>> selftests/bpf: Test tracing_multi link with BTF ids of the same address
>
> TL;DR: Test nit only: the attach_same_addr subtest skips without printing=
 a
> reason, so a SKIP is hard to interpret. A printf() before test__skip() co=
uld
> help, though the review says a bare skip may be acceptable.

...

> A subsystem pattern flags this skip as potentially concerning.  The
> selftests guide says to report a test that skips silently with no
> message.

bpf-ci... seriously?

humans and bots MUST not report nits.
