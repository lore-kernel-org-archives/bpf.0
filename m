Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D33A9DA1
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003122; cv=pass; b=siDihkT0zlwzBKuCOlehWsY0Eb5IJxIRKCeDa/v9M7C1nwqu0KT8xGMdiUInK1QPtB1yJ0CBbpfbgfSd1tmu8sPc/1q3IymOVsmW7/Zq1nQhlAczXeA0hJmwu3PfBtHUiKfkkk7bgeRY6zgrcyKxBk45lPhRYoVSfvd6hfL4WJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003122; c=relaxed/simple;
	bh=Ul7GuxkaVhigC+VNw81nmS37qoZ1+T7jXP9zqROO3ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTju8bkKzt/x3St1v/bInz2czRICR7l0H/epTPBwaKv2tt9b6kk8Apjc6Uf2jtmsG0V6o7BQHu8/OdX0zrVdTGdFw2r6kWHa+lyplAdXL2PFBmP70Z0ixkARQb+W8XjWB5SZnxPku5y8XIOBG5kqbwzBclr/6E9fF0zAMSoAcrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhrsKRbT; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhrsKRbT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccdf36f63dso31325ad.0
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 14:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787003120; cv=none;
        d=google.com; s=arc-20260327;
        b=R3cMw+HxfNa2iNeZT5PhlbwTET8AEjMaWrGsIr5ooyN6E/ILE4uVcNlXHPqgOUw+Sg
         Cjc1CaIYflBu31WI11PyBhlnVQZ8oAEYYOPco0Z/E9vYjT38ONvMe+fzu17fVZsoOMbk
         IIqHhWXbhyHfti4nPK8dmGWEeFmMbkYLVrn7XC15vAMlvJwHOtRjN7SQpg/eQicvENP7
         d/Dzcw7sI5UCQ4e0LSBKLChfuHGpH7DiA2nRlEjajJqbFIOGUBY6myXMVSOWIaWmNXK3
         SnU2SDBn018x8KgMlGMrMPxGwqQLr9Dgc4FcAcVqSBBziJDjFIqWauLe7voQqCvyqaQ/
         uypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i0xcwMjf7sgDjGuJ1B5j2NzWRjcW56xg2K8cs35uSKU=;
        fh=zdyTC/iSZL1e+GrBqRZx1wGt+gRQA+A5BfwRvc38a40=;
        b=pJXGY2ZnCy61dm3wJL6pyBSWG4UXK+oN+wC0nGDIELpnTePYmVLNwpP556flR/HdqA
         8+asnnlEH5B92NwDklhgC4oYPU3X6sD/6eZrkaerEPcGiWypGi5puO9CZGl1nwQTLJVX
         9g5Dr1/VuimMOVNZQZ1rFGJyAEacZRoDR+3gZjjJnsHql/N0Tx/KdLwtjdzlEsT8H6Hk
         S6XMRRQ4+G5kxxFXPh0lYCEd9utLxP47xeGSNu5Kdo6qHmmrQqk+/4oFjK3hnk+eYbmQ
         Jc2eaG3Y5l6heevKG0if5KFy2yY3qo2EfeQGzS7DrtWc0UqZgyfW6/A/nQ/uzTDk15UT
         T/Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787003120; x=1787607920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0xcwMjf7sgDjGuJ1B5j2NzWRjcW56xg2K8cs35uSKU=;
        b=YhrsKRbTVM/kI4s3qh5SDOa92o2c/uqxsGUaKinRv+Z/JiP3DQBAMUHHAyyAX6qlBx
         twxbT1IC05P5rG5HzaOABOncu3oyku/+YsPswkdSsr0VqjyVa3YS9gT3pMfjvuUwtYk+
         /IQ5webGtPngzRxnEP/ZsGQVQxENd5Zab3tqk5MmkxGBapGNegursqvSRVsUi/Zj5jfl
         WoExawFnrgauOdLCKydg0xIA3/1P6exfPnNOEUUICCMn5zpFbjv56ieYKNACBarlP2zv
         762GSYP8Rjzcl6MlKLzuO9mApsSONtz6xR1sh9NvYf2KN7kM/z3Zr3DD7RhIcWKBsCkD
         zRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003120; x=1787607920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0xcwMjf7sgDjGuJ1B5j2NzWRjcW56xg2K8cs35uSKU=;
        b=ipCU0I3Q3q0/HEBcloHY5Cb3mPRgHPQa3Ral51HbLc/MpY1i6b6T8oT7OMMfuorV0+
         DOIuRtkaEf5rnCRP0rlCe9CmfIUkGkkPmYa5EmNGPBGsHh47gQafgUtoe1/ditKghnoE
         fz40sebLZkhIb1eOE3p3cPrC/knYwIU+2zUbBtayCY1TeQXvM9NcgRcdoYPSMMtnolO7
         ZiKlUjL9UvGx0RQHYYe3dOJIFRaJKNs/h8jhsVOFwah1SSe6yP5iLOIAy32Du9OFRqof
         TskjtEM6odgFlLMeGmy3qETETcI0g2GqsEPAuPN6yu0Autz49KEqUPcaUzfaMW/xlL/T
         G8gA==
X-Forwarded-Encrypted: i=1; AHgh+Rqv2I+jY73rUXeyrCyrVRUAwthOpwFm+6AIZLSpSee5u96ZdbSugkXcPSaUJLLffy8aou8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHtb/XFld8FrRgr01y4I7rtmkBGKUa7hDJQURdLZ+W7MvGJ8n
	qdrlOcYCM1xsIoYFqyprYop6iEz/7MvJlL3DUk8aa4/svSLxGFnKhd50P2KUOzHdHqKdW8fEXnK
	KXtwatKSRGTfFWG+JWg6gX9qzkLDlKUSx1TUmjfZM
X-Gm-Gg: AR+sD10RR7MmB7QW9GWVvmPa/ZlMse8ZnMO5P74T77C4vpWSB2Iz0twQqIqloZ7T/iu
	dGzyNQXouBLPS9Q2b9D28UAz17colxDGfGUz72A0vbyn7myS37usV8VQNujJTQZLdzcA5QAaCiI
	ep4i3a5R9HcAy0AA/A4vbOfjVp4JsF4fYWWzp6y2jgNVipu9mb8VaNADqjZJqyNpF+AkfN6lXSE
	9y5aCLta2Ukf9j2xv6NMz+cn4PL043x422yH5XS1cNiuLrHbuTIjlh5BWYwEyOXU/A5YwK8Mxzy
	Nf7t6j9kn0mMnEKBU2qzfIvZlXRITXTJd0SFlgILY+2HXuwnq5UXAIWKRISFfrTT/2b4L/SoG3q
	Dyq5/AvvWCilphCnrAJIv73eu+z3Y+Y5r/VofVX6BjUU=
X-Received: by 2002:a17:903:3d0f:b0:2bf:3579:cdaa with SMTP id
 d9443c01a7336-2d5cca0821emr3898765ad.10.1787003119386; Mon, 17 Aug 2026
 14:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 17 Aug 2026 14:45:08 -0700
X-Gm-Features: AcwNN1X-PrLuTfYUH8HnqqozWNkSjG5BNtWITsNii8iA8utNKIgF2z0jsb6e5Es
Message-ID: <CAEAWyHerP_n3ucJaEqrCZqVFQTPKzydYXOPYZkk8d0iKf8UWow@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/15] gve: AdminQ mode related refactors
To: netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	przemyslaw.kitszel@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 7:14=E2=80=AFPM Harshitha Ramamurthy
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

Sashiko has spotted a few issues - will look through them and fix them in v=
5.

>
> Changes in v4:
> - Reduce code churn by placing new functions directly in gve_adminq.c, in=
troducing final tab spacing
>   and using local variable (Przemek Kitszel)
> - Fix kdoc formatting and drop spurious management interrupt(patch 9)
> - Propagate release_db_resources naming change (patch 12)
> - Remove double logging in destroy queues path (patch 14)
> - v3: https://lore.kernel.org/netdev/20260803184630.3813311-1-hramamurthy=
@google.com/
>
> Changes in v3:
> - Fix driver compatibility verification in the reset and recovery paths (=
patches 2, 8).
> - Mark gve_adminq_get_device_properties() with __maybe_unused ahead of it=
s usage (patch 7).
> - Refine error handling and resource cleanup in reset, probe, and queue c=
reation paths (patches 8, 9, 11, 14).
> - Keep IRQ doorbell allocation/release in control plane resource helpers =
(patch 12).
> - Minor fixes: fix TOCTOU issue for link speed, correct kdoc comments, an=
d remove redundant teardown calls (patches 4, 11, 15).
> - v2: https://lore.kernel.org/netdev/20260602235900.3050782-1-hramamurthy=
@google.com/
>
> Changes in v2:
> - Rebased against latest net-next to resolve apply failure for patch 5
> - Fixed a few typos in commit messages of patch 9 and 14
> - Fixed a kdoc warning in patch 9
> - v1: https://lore.kernel.org/netdev/20260601175437.3767283-1-hramamurthy=
@google.com/
> Harshitha Ramamurthy (9):
>   gve: don't pass in unused parameter to gve_adminq_free
>   gve: refactor initialization with helper functions
>   gve: add a few helper functions to set device properties
>   gve: add struct gve_device_info to hold device properties
>   gve: introduce control plane operations structure
>   gve: introduce ctrl ops to set vectors and Qs
>   gve: introduce gve_adminq_get_device_properties()
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
>  drivers/net/ethernet/google/gve/gve.h         |  89 +-
>  drivers/net/ethernet/google/gve/gve_adminq.c  | 437 ++++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
>  drivers/net/ethernet/google/gve/gve_dqo.h     |   2 +-
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
>  .../net/ethernet/google/gve/gve_flow_rule.c   |  15 +-
>  drivers/net/ethernet/google/gve/gve_main.c    | 940 +++++++++---------
>  7 files changed, 957 insertions(+), 556 deletions(-)
>
> --
> 2.55.0.691.gc56d675ccc-goog
>
