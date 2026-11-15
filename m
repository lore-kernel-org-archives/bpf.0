Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767296;
	b=i4vJC7Jh5jrKRTGjJ9Hjxf5lUemUqZMMmRU61HcBJRQMKWtd+X+rOkDp4ETqAiK6ffZY
	 peG7T9XM4VRfucxRR8xxmTa2673/hjZxoFU19FV+lB5KhHBBOGPvtwk5xMerTIVM6J4Ea
	 AoxVMqzf7N9ug5mBWKwwGH40nuj6a+DqIUHO98tbWLmtTdOJRY9mXUgssH4Ozp+5GVSQ1
	 Raw6hHS4I3PeASDZZcb3HFw6+rM6Y0uMV+NF2JBqZgDuvfPl41cD8mpda9Z7kdu/CGxfu
	 x+kAynQKamW5VoQWOt3arkCuIVMahKt1641JUhZQkJM5JHrBu1vpnTNoSB6FONYgNZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
	b=naYCvoTA3UgeHWCadNFk6teZCzQIrQlw8Qw/NeKHcPF5fkFAFmkOH31rw1nFPJF515Yz
	 W1mdhBCIPAJ80oTa+eK+t77W3bn+4dpPA+iHplxBLm3Dxt3JStXJPvVlx5Hb8MQRi3TKn
	 0oSIZGt/9zmnh++6AIm+XyHsRIAMGCCSVOXfe2TQzMJJVXNasdw8RdYIa+2lmn8Iq/ugP
	 kVQNajEZCpsoVVRkpxLpEu3Rd02MfOuj3J/U0rQZeFJXUxMK3Or5uCNpWSG8OXZ5VTBgt
	 LDgsvtewSihsWBLqYjKsGZSPekrnC3uNKaMU8bn/NlVWCy2fMc1cY3HUo5UVdTGuvZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52795606A327
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 18:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52795606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so1344664b3a.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794767296; x=1795372096; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=HBV5nxYvdpLlRvsxsYLbFKr5P34f8mj9a/XJil7dVolrFQomVVkyecHxP6BgFGwDxs
         /19GzczoyqLC7fuxmwJyN2rwUymD2CerKLMnjfS/2CRMvt+ynLs5gkxwuVBuAu3q9J20
         IzB2wBplZLjMFwEGGW7prCWCSa7Aywa/5h22qXYWy2au5OKH6AKODohFFnhhSeGrFYHI
         n+FqPiDDYHHddi3JAW7aghC+X3tcMJhczYrIX5Hp62B1gpJjhhKWZLANouBkWkfFg5wA
         r6zaGmjBjVlFtwZxS8OaoxZbnmYU5uIROK1UqsDLBtdOM41dsZCnP9Jsrl/zETDD4H/q
         kP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794767296; x=1795372096;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=kNmBAoX7ErSjGbC7ENCn68ZCp02XWEyEVPgxcjmCEuGRAQ8W5/AuUtJDL5O7/b22Cs
         05UvQt2n4Tm2JznbxZGyHnraY+eZrxGVlaiL7Rd/XY1bXXaoivBwXWRGEwPRM3n+vLzT
         BpruUN+iAyGC1deZ/WEvg1hPVRmQq1AHSnpxO+jNW/Jbb1Fezzii7lz5jTN3e+AAiXZe
         t2vrraROVDXEwqSopRc+oir+kv5eARvYvf3ZmbRR+fIBq2hH+ZT+qzbzfS4HAIgjWZ7R
         /SwlQNFco20W2eARen+6Spcd8ELTkWftppBpzX+bZ1MTD1R3QWf7Q05tKpI58tnjhgnS
         rHvA==
X-Forwarded-Encrypted: i=1; AL+hErGGOtHMKFAg2pQXMp672Usf2yJQZ1/z4kdPKPCSDWUQEruBTXCQOgexreZ77VOURj21KFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cl+/Uhc66w4DUqxkTbYNZw6SwoMDxE3IqE3MCHmw+uD7n0bU5
	JNMuCEhrLy7Xaz35wD/ABQDOeiufqKWYh8UB4nRPJKowKU0gDICA524U
X-Gm-Gg: AYBFou2dDZVA1C4dM6N6dvzVKNWTZ4AWVBvL41N+nSr9EzsVRxttJz0gMjusEtGNgHx
	fPGARPzbdlQNkdQ7PsZLtLDZ/tKkfrXthoqlbEK1HqxFxTc8UbOUXIY5XW5XG/JocaxHbFYx+vy
	K6waFF7eJX2fuAUaWu3j4bP74d1XV4jf8H9S4qEu25JflwcbK+xZioKAO2njueT0r1gYCT6ErVw
	8DwCDNZA6jTgdwvDcOMW8ypeW7Awu5mCzaLQNhgkSIB1KwblB/HQ/UIoDH3YDq3d5TrVJs3TGTa
	O0hmVYIa528DS/FLCNfzx2b5sa8yBxzNlXWYpdObalrZ7+yozZNqBa3/uhQrv+M0MMlw+hAzwUk
	YLoimtAJl4l6yKNWpoMYHrngxAvv1SH4q+E/26P/A2ExLNL1x1gHoAjfMltsG63rR2TAbcCmSw+
	wHIe8qV5HEwtbl3/Gausi2f62hO9P/rT6VJ3F0hIB6iGezfDgePRd7Ze6eVWf1nVn7QbyXkXF08
	GOebwFUfVVTab0ihV9ceEntZQOczFPQSPlBRdmAA+YuKdMlLfriwfnyJHnj51F16xq3JODsEDhD
	722VkI5RY2Dcpwvz6DHv8YQxSWzQcC0JtqVCn+bOKiJfx0sdz3BWQEF+CMu8QrMJou38SpGTtZL
	CxInsqVj9QzqvpzcYhNg07SyJWHs3xY1WFw==
X-Received: by 2002:a05:6a00:230c:b0:89f:d620:226 with SMTP id d2e1a72fcca58-8beb619bec4mr7100607b3a.24.1794767295502;
        Sun, 15 Nov 2026 10:28:15 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcce6bsm2804318b3a.1.2026.11.15.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 10:28:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 18:28:14 +0000
Message-Id: <DMVZWOMFDBX6.3HVETC9L8RUEU@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Amir Goldstein"
 <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>
Cc: "Chris Down" <chris@chrisdown.name>, "Miklos Szeredi"
 <mszeredi@redhat.com>, <linux-unionfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 00/13] fs: let d_real() fail
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
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

On Sun, Nov 15, 2026 at 06:01 AM Christian Brauner <brauner@kernel.org> wrote:
> As Amir pointed out the correct fix is to teach the callers to deal with
> an error. So d_real() may now fail for D_REAL_DATA and all callers
> handle it: uprobes fail when they're created, IMA treats it like failing
> to hash the file, IPE denies and the bpf kfunc returns NULL. Then
> d_real_inode() goes away so nobody can ignore the error again. The first
> patch only drops the WARN.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
