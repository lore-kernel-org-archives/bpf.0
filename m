Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269C346FB3
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351319; cv=pass; b=uZlCYRGanMXoT8fYOU1dX8813/7BnoQC2jjk++DxfLEK2Q7O3K4DduafxutFQN31PB91Zp0SHyTAFQu9P++TZHibb61h0xS9C0yObCiImllqISSPxiLKK8kvBTFSCtlD81mnGYLm+OeZee4WW9QZ0r6TPMuk2n7sEu/UEvNtr9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351319; c=relaxed/simple;
	bh=Rw/4a/NURQMfsq8MHGhIKpn1A3GRmoCF9WKCmClKTZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+IYg71tVbp9Mad0s8lsdtWl6JR6DiTJ1wsKfh4ORj2aS8kckGxmfwgx5Rxj7GIvu6YwcW1I749BftaHptuYb/IXYHwoFKLsvS6DaxgmGk4NdbLsTLnN4lT682tYvNxYGvBM+xUmfmRvPYdaSo1IZRT4x2LPBJm6s7Dumk4HBsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZP7fhWC; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZP7fhWC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf2911f93cso365ad.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 15:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780351317; cv=none;
        d=google.com; s=arc-20240605;
        b=h602vtBnQBKej1gM59Hs+qxE/LBC9aN0sBzGUOSSdJ4ttJA/sc6DLcjCQi3u3LocnG
         VKkaWA0S+07rnCahW1hBz6r7pxVjjF+JHCJZ8sf+CfC6Q7XRbSxAg5Z7/ZZLyfT9iDsz
         81MpJbikRVgVcw3wXvvZoVkWY/CxnGs7qKsCAMHsfYKgZ9ZpSXYeHTdTnuP8zunjg2mS
         ObLWjSir6SLuLDsSA/dwwVUndmdtz7Op0Wxm+oSYjSixiL9tSG6mdCh2QA/gyPcTDU+/
         0hTlIt2rOrP/V5E6je8HHT3h2DDVTLpUvH9n6QAhDkGHqrit2An1tCquskjdyE717dyX
         y79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vF05xsD64swUE1S4mP39pcL6StP9wDO4XWqjCABBN+Q=;
        fh=yDzTxmygCGVPxkfm35/OQOOMvsyCbCYxbVbIVpO53Aw=;
        b=dCCRGS2YFvBPi4cHatbQbENW4F6QWj94GEqmbG4Azg5PE0ynbdF9NuvYvM0Uf2Jl/1
         ndSNLNqYbl+8pf8oKd54iKnNGBlYsEY6lnNpRGNhiTzZ0JHYeX4nlcacoxVDvk/fen+O
         oF/ys7UBVUWhnhCB0QuA0CPstoPHGxkTFElR8xRpU/dA3wxdKqOFjdxZgiG/x3xcjCMA
         QfmgN/wSgAto6HJIMLHf0mbIGHr/fVor+8PuQs10K4QVpiSAR+ykSYjJRM2cj6YinJCp
         ls/l8m/D2AP4CCjOa7JHS4WmfBWUrbjXda0vCirPXaoXRzLSbm9NwP/M+00Uen0imMAr
         axJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351317; x=1780956117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF05xsD64swUE1S4mP39pcL6StP9wDO4XWqjCABBN+Q=;
        b=kZP7fhWCFMd9s7ldpgtbmCwVvkWcwPnr2/xX3rDjUAvg4sageR5K4KzZOc5W/UHqOW
         ZFSNV/F3hFjedo4PB+ToOCKNq+ZHrNmLEPo7C0mntEQINc6uAqdIvO1GJV0/eSqkPn32
         dB9QBr3Zm1mNcTAdM9E/nGZYj58D93quYdfV6GnkKoojU7vHfof0lM9T4To02qlJHb/E
         eWX/iCkJ1TMrxdbZbo/I1PwC9+sNa8mOHGOmYKGH0YOhey2hb+Vy5IgQfbnAbig5sEMT
         3cQpB4YR0Zy09M+4Tbk5HAvkGoew7/Q2xjDpyf3tlEcDN+WKFB9ls6DwprKOWyuBcoO1
         CRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351317; x=1780956117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vF05xsD64swUE1S4mP39pcL6StP9wDO4XWqjCABBN+Q=;
        b=Eo/1avgMmZbiyIWeM6Ro+WbGNpht2rhUhqt3AjDO1P7bKw+r3Vhs2GszUHos6/Wp7D
         x2LNbEGgzWSkFaotMCXToSkw3JPKpIZBGsQlf/nUgwC3PMLC3kzRjjcBYVHrbPduOy3P
         l2dQtNoz00uS8s11M4BhqvannQSt8varyizTBGKbXOkkZtkG1eOTD8gpwaMa+AkfqrkT
         FbU5STMWLZS0zOKZCIFXoIZ2cFy4Qu60qZlY4QiMa8+T3gt2WR7qCEYq9RS84GRDdHL7
         1qvqBoT7W/ZhiDtDeRB70W1+0UJQBC0H4JVaJcA4B1wMG4ga9hOA421SKzdqi98WXVQQ
         H4ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ89RKDgHq0uqvPyZ3hClRA0ua1C0mlBQvQrOnYXPVm9Mm2eP4rHzNyILeEPXpji26rqu20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8mQjrp1GoumjkOKpp+iGb6ZnC5neEjbIY7PRRhTLeDFzloQ8
	kQ+skHkSpjgpOwl/Fj0nhdnhskKKTvKUNlhq0rm6X4VUkV9jO1vgBMW/2iDDlwpYFm5QxsxbC2/
	qQZ63WolNBLbM+gS85Bw4DIe42QkQALnu+8oQKa7o
X-Gm-Gg: Acq92OFPX9JLRp6zOrvddbpixikO9oG22gRk1o+bZvBB/+cbxnwLXgyc3XidV2C4Gkz
	MW6CDAmKKAu46RQVKdFla3zEkBB27EQ4/AywtVNWkQ8o5VlD5SUH+lJ1mFzuGkRj5O4SG3usxSV
	tc/7udTXR9AKOKMqOe4sYfHvRYAMxcpjbT4sunssmaEHjRGqJTi4OlARXpZx6RYLyNObYgeq226
	Ee4qSurvkU5sWvk8MUvC49CXdpDub4v6uL2SsDJSCPmRLiO0JghcgSEhqHLtmyM/+4n8mLC9fim
	MZjbSugzT1twHhBLpsRWLOKeO/caewyZts7MlHQEIOYBrq4heGjLWy7+vS+zY2zZJWXKtPdZyFR
	/jf7ft3lPctmI9F8=
X-Received: by 2002:a17:902:ecc3:b0:2c0:bf57:8746 with SMTP id
 d9443c01a7336-2c10eb100e7mr1008545ad.18.1780351315809; Mon, 01 Jun 2026
 15:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 1 Jun 2026 15:01:44 -0700
X-Gm-Features: AVHnY4KQyJtSfT5RIzZL1aSdVjjyck_NGH23XlGFpeG35bMFP6xN4cFz-7dZ_P4
Message-ID: <CAEAWyHf+G2ts+4Rs75mgVpqQpMa5fK=bdahZGRC0ay79D6U+8w@mail.gmail.com>
Subject: Re: [PATCH net-next 00/15] gve: AdminQ mode related refactors
To: netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, willemb@google.com, jordanrhee@google.com, 
	jfraker@google.com, nktgrg@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 10:54=E2=80=AFAM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> This series is preparing the driver for the addition of a new control
> plane mode(MailboxQ) by commonizing and reusing as much code as possible.
> MailboxQ is a new control plane infrastructure which uses mailbox queues.
> This is a new control plane to communicate with the device when the drive=
r
> is running on bare-metal instances as well as newer versions of the devic=
e.
>
> This series contains 2 main changes to the gve driver's existing control
> plane(AdminQ):
> 1) refactor some initialization/teardown path methods to make it work for
>    both control planes.
> 2) add gve_ctrl_ops structure to the driver for various control plane
>    operations
>
> The refactors are mainly around the init, reset and recover paths so that
> functionalities could be moved into the control ops like 'set_num_queues'=
,
> 'set_num_ntfy_blks' etc.
>
> This patch series only sets the control ops for AdminQ mode. This is
> intended as a preparation for adding MailboxQ mode in upcoming series
> which will add the new control plane infrastructure and then introduce
> the corresponding control ops for MailboxQ mode.
>
> The entire list of future patches can be found here for reference:
> https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/
>
> Harshitha Ramamurthy (9):
>   gve: don't pass in unused parameter to gve_adminq_free
>   gve: refactor initialization with helper functions
>   gve: introduce gve_adminq_get_device_properties()
>   gve: add a few helper functions to set device properties
>   gve: add struct gve_device_info to hold device properties
>   gve: introduce control plane operations structure
>   gve: introduce ctrl ops to set vectors and Qs
>   gve: refactor gve_init_priv for reset path
>   gve: add ctrl ops to for queue operations
>
> Joshua Washington (6):
>   gve: simplify reset logic
>   gve: add gve_ctrl_ops for gve initialization/teardown sequences
>   gve: split up notify block allocation and setup paths
>   gve: introduce new methods to handle IRQ doorbells
>   gve: setup and teardown management interrupts
>   gve: add link status/speed ctrl ops
>

Apply failure reproduced locally (patch 5 conflict).
Will send a rebased v2 after the 24h window.

Thanks,
Harshitha

>  drivers/net/ethernet/google/gve/gve.h         |  91 +-
>  drivers/net/ethernet/google/gve/gve_adminq.c  | 459 +++++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
>  drivers/net/ethernet/google/gve/gve_dqo.h     |   2 +-
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
>  drivers/net/ethernet/google/gve/gve_main.c    | 876 +++++++++---------
>  6 files changed, 913 insertions(+), 545 deletions(-)
>
> --
> 2.54.0.669.g59709faab0-goog
>
