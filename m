Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309E34F247
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305146; cv=pass; b=lWicE3VdNA/1wG6Ldk8KDI+j/VEf54spZnE3xCkR/izC0E8q3rI5Etfc31NVex7pNdV0JtrDUowpN1Poxh7qZjDe3G4pVJi6+e9xHXo+d9dsx/9dv/3sAngOsS0uvnXBmIUibEbviU1wIaot/wd0XNP/PqC8CgP2o1dsUy5mXNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305146; c=relaxed/simple;
	bh=LlEiwFBpI5a1pWwuwUGxSGetmyWDWx5F8pT9P1r9ZNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjz67nuwXdZ60U5Xpun7/2NRxeT9ugyv9+VUKsgpbDcpf41dMw0iP8n5H3KzxZP7qJd7A0YVKkZoLwhVIu8I6QL40DGPWtD+5za67eulyd5RClkg8IO/xgs5K3WedOAs6k2pMlKX6wg7vt307XyleH7NxnbgTw3Iu8HB/nwcJH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvR10F6o; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvR10F6o"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e4b76cccafso8528025ad.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 09:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791305145; cv=none;
        d=google.com; s=arc-20260327;
        b=YWgHdVWPXXQAeU7fb/Mucf+6f1ygSzamsxWA0lLXeXby6kmKQXv0nPXgCbzdjrNU23
         nuGvKcT0YCsstqjTmZONAijecZBi1kvsequAN9ASPXkzJXxCl84j5lCzN+dWw0n6hgJF
         JPsA9FL4AhCKwQyNbm0UCjK+MPwbPmDPT22cIf94KChA0Y9yj4VbQpvL4NZzeKcZ0dlT
         NWH/aw2ikV9dkSi4iOCkQMQm1+6t5AnOQq2n+WugBc/GTnQnhUreCJpub2D0mxyugrsT
         tnZaRzCxCR9WMxRiwOHKGnJjJv8yqv0TqMC6GLxZq1ZVLZ+DzIqhJM7eXAGmh4QeBLNd
         jdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LlEiwFBpI5a1pWwuwUGxSGetmyWDWx5F8pT9P1r9ZNM=;
        fh=Ns7fIF0/ps+LpNDt5HQ9CPh9zCVEZV+CUS1P908HfgQ=;
        b=jZnze/isfRIHeFuElZXvoOBRbR1fZz9nqzwi9Q0Lu2asOyfU7/4TcNJHKYr91SUyWn
         COJcuYY9eYwp/qsygnLPF20zrLU2YMykRPF1ldDnGLJyPLcdE6KaIaGVlrKMARxBO9DP
         TEC5Xouj2QTbBUqoM4ee+Pm0JOej+DKIynCVGxuvHdE05iBaUFyKgbIHq0vjXeAMlfFn
         lxd748mJGfpBrAI78ky7PmuUujkvoT05HbBALE23IpewBm4UgTeJVC47Qqo5j48eOk3l
         uLhk3LA1oi5dL96w0t5KyG4qJ/Sc7qbKe1SajIGna6YqcsOWgD1Q7yvfB1zP47cd5hoM
         HmrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791305145; x=1791909945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LlEiwFBpI5a1pWwuwUGxSGetmyWDWx5F8pT9P1r9ZNM=;
        b=BvR10F6oc/FK981T4tNNpmCa8CtM/O9x7VbALHd0EYeAW5ooCVckLsGCbIB97TqGvN
         QnuN3EYS/e4CmDXpT15yD2MYPcRa3RL+OeC8SmFBU1D+rkiuBB5yf3y2xnU2UP0Ywg6U
         BY3OIVdr+GCt7tqCIwVuGDOPGnvJu9fVvV+v4yLTVVQX7D6Qh/4H8RgvEFTFkmXxQUTv
         /i9yfvbThKaktalN46gZDH8dRDx0zFz5y84aoxfJ0hpLlwI+cI68igchEjXfKJp0PsSg
         L9gbQ4zhGsDw6vtfnqTEzUjuoEAhpubdilFJ0Bulm/6jS4tiu8kVm4C+QOM3878uL7zh
         0j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791305145; x=1791909945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LlEiwFBpI5a1pWwuwUGxSGetmyWDWx5F8pT9P1r9ZNM=;
        b=tr5qFFYy0L617u0n/eyY3piPeOWmOUP+EfLE8VOI/SqpIBaEHelYDrJb9x/qTK6tPh
         dx5rr0XpbNq1hB9i1sZWQ5SlYiTx4Uxo2YPAhwMtkz5MB9fOQYhEUD/60E2ytkIdCd2o
         IQeNOgOJa/ZgBxCVLGPS7cwGBNy+omMDgSC94LFeaTcePMQqaG7eV+bR87Vn/5pNPXzb
         b4oYm7Q4MkBVpM3DmzoSLTRBW/l/aSev0smjhDfbc4L4nLEmcDUNTXDZTe3i3U6CRr78
         FIJJJWmxF8PnpRfbslHkzowPYSGnDkSY/Yue3J1k6bs68qoB/hFhb8dVQa5BMej2J75t
         Tu2g==
X-Forwarded-Encrypted: i=1; AKwUvBzP81dQPt5WcC16P/i114aStG4LDVZJR0P0IuepRbAnIUXJ5A61dra0zAnQ7oUHhO2HKtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkJVEY6y7ZMv9wbgObYGfAPd0NJ6WloMdupT2gi+4PlN4P1IqJ
	INgbUEMlC85BYYm9DIHRT5fRsZ7bKquy1hgGUp2HczBFph7KU6SWDCbn0eSvSKwgE+jDHwO5iHy
	ozS+0Py8a4yMuQI6auX91qOYtejeIgv8=
X-Gm-Gg: AYBFou0ZW5ftkKucBD8w3aeVQHZOXggabg7VBCfp4JZr04zblzmdt6rJUtJDvmsTu+Z
	CoNzw3luf2+V3W8DrZO59ObHs3QoKDeW+L6MwoFJpuvksYrsk2PFLjZkbcZaFt1hOqkISkdlDPe
	vpMrSsueGtDCUK8ggEYo9Q6a10eWgnN7a2jb+aO6zyxAOik236sYN3K/3+5Ail4L7FseHCUBM2a
	EBO7kDnGkIVuSCkXo81zCMAREvGfmsPfEWebhRxp3iw/zEyvWBx20O6uFNmIuoenK5pR+abFGJW
	r87KJJNRB5wD3Khf2uirb/0ZWTjEeYloJLziZaHwD/Uh0So8acMVZlXR9Ba4zBm5Dtevrz3VK38
	fdRN7cNo4iv+EV6XQXU/enQZFy7i+E+1Go3QkEqI1/OYIHr39qwZVmhD2sPi+a7w45RWCOwASCO
	7zSUwZugkQ
X-Received: by 2002:a17:902:ebc6:b0:2df:accf:e873 with SMTP id
 d9443c01a7336-2e5ffabc334mr770415ad.4.1791305144589; Tue, 06 Oct 2026
 09:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com> <179130481603.2708704.11559670764976269822.git-patchwork-notify@kernel.org>
In-Reply-To: <179130481603.2708704.11559670764976269822.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Oct 2026 09:45:33 -0700
X-Gm-Features: AclHuK-ql3p0mJqAr_v2C-xkDfFBzi520PGPZTtBbL7wkcxwWn5ypYHXors70rs
Message-ID: <CAADnVQLr0_ByvMEhgixmKNshwKBD5oXQpjQ3GixovGfu6hisPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/43] bpf: use scalar evolution to widen
 bounded loops
To: patchwork-bot+netdevbpf@kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:

and reverted.
