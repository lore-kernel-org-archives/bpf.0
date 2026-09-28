Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E82D1F7B
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790563637; cv=pass; b=o1kI52ZVKk97AB7i8gPTIEDl9DYzH+k3FpdigMC9/BsnbHMiM3gpQ9CrEA32nxA70fLUXEbLV017Rk2pPtHy6pQw4eurl+OnIzgPciGiKwJjZC8llIqh4ru/has9UYV0WUa6pNB3tFI0vwINgAazl+JVcMY1sXocTek3CD5nm0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790563637; c=relaxed/simple;
	bh=kfLoILawQtt3GmHszvYMld0py7d1Fw/qISyON4KY3vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spqxFPClZXMyW7EFjnMMnWPk8Z56Fief1zxl3H8Hai8xP46GFVjm/yhVpY6H204l2lCXZ2rstfPPlsNIZZ9sMRRFByHtnMFc+rRuklq798jKqb9qvUpUKJoSGWwMsK5TNnnXjq+ii5RNs9BWrE7hb1jRjR3QBZK7FiSXB0I2ybg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sl9KQhN+; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl9KQhN+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so47585ad.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 19:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790563635; cv=none;
        d=google.com; s=arc-20260327;
        b=E6FqjpfOZWnlpDgla8FAqRdEcyN2HWea2lD8qO2/wXAZxJ/LqUpra9gmSf6YWgSmt5
         ULV9u0h/qbuuqfbzA1ZFoJtnVeLvnoJbeXRLVVbY/Kw3hIxS52HN0rjulREat5narHhB
         KrKuIOIRsL4zEHUOVMHt29WYaYhl8UPeQOH6ioIWevboRKxFdULXMfJ2zFoxk3d/BPSe
         kLf+QEYBnjnFZmXBquPCS1vGb7NXOhwEehtH1EsK+2808jlB83KZ9Etx3trvgrrDYoL3
         XWt+oOz98x4iAiTzSuXoNQJEe6NG25HZhVVj0IuS7H7pLczKFpdxQutxtpycjnCmvEpV
         QHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=augEudhXCRPhiwglRSNBL2Iu+v3w4mRzMH115XwWtzU=;
        fh=CkslIGpORM1/TexYgaoTR7l+xhNfgCQNRT8RZgK8sQs=;
        b=bquPK5MeJc3My+fX63G5sFdsQuLR6B2Opjo5WEeNU00JxikR26QvTM1arO8yz+xUTh
         iUXSsxwLfOfNURR+b1E4I3YvOBxrzKeK9q4LKbC88nW9VObV9Du3wwR5bK3zLPPo3u0i
         oTA+O554uQBD352k1CzR45rsls61In1pHijGm2DP1WmtOkmmQSeONFRokkFSrbdQHLpv
         o/hBRYXjTputMpNLnAluk6aVMGRFoYEtPbb6CJFiSeLyFRL+G3Hm2YCYjrJoaDHv9YLW
         yibnqrHAHLqN8oLUuaiWBvP5OlbZi0TPH0isGUnbFM5XBghiavasoe/EuosDqbHCuWrK
         Xoeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790563635; x=1791168435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=augEudhXCRPhiwglRSNBL2Iu+v3w4mRzMH115XwWtzU=;
        b=sl9KQhN+QEgFViLK1ZumHInb9dLoKmqlMLEtfjnC5c/NImBRV2X84xcLiDOgtWvEoX
         rXDWHJFPddtrenuz+7cGSDkEGpZ1PXkEEcPgXvj9KkXj/gObToD7Sh2soBldwb1PNna9
         pP9/pdFvSfoWYuXWyDxKwEHnqZ7LV7Km5XYapKC+0AveZaCz9Tw7pBjcfRQ7NgdFTOBG
         66ZkjiwkIybx+E5nLzNMQtdv3LWM1iyelLpQZ2Y4yXCY8ynISkvDR2Wa3sUd+hjPaSB9
         Ry+uMw9/+wuf6WIfJMyy1rV6A+CCS3QyxgqWSSuvJXOsTEp46pGK2qnLp9CH0i3QNk2V
         maGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790563635; x=1791168435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=augEudhXCRPhiwglRSNBL2Iu+v3w4mRzMH115XwWtzU=;
        b=L9oBF6LEVsp7xHzbnpqUKzh6J4zDikNOWR5tlly9LNlZfNGWpSQll87bfh5hOByM1g
         zzxBwcwllazcXBMP4pXKywQuBwgngR9byuRLsXwrih2DHoQHa82ZYrWrT7vgmxoWs7g5
         Z2o9/aq85bzk2V0pYfKZLSnoCUsLrSh4ICpa17EvOVDlNiXVyKQt5BlWt/E044U/qicc
         L1j8RvEpvJbMaWKe6v04ce7vN3b83yGgEAExPlaaZpTyacsxk+nqItiIay3IwwYi6lkM
         pAQbdRzNvFVsI9jEGxFKYgmoVVx6dIJp7bShGTTcCjgimsF0ZJ8ZrHu2pEix/t6xYpHM
         Nuyg==
X-Forwarded-Encrypted: i=1; AKwUvBzFW54+jVC8IwUAgceDoNZyI7PUgWZw8TjZLlbbzGzo18R1ZQglhNQtZMUg6pSs/yC9GkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6HiAxRiJ/IwDuz0XRgwKoM+BWuQ4INE9nPCw9TIJoFKL69Qbv
	MQXYSkihL54+vfUfvmUorgZN6kOy7CtamJGkLyQGoUeIQDbHGoi1nnSSIxmKIjawQ+p5xz0wqz8
	E/B45U9cU9gqMO0wqIv/Q2433eWux37slTYb5oVfL
X-Gm-Gg: AYBFou2W4N+rkUviVGsthgoiZcL2yA4Xlun0+S0TdlbGVQXSP2iU5FwV3M7PZ5hrmBh
	RKx9RAiK1BIKVRu/lfD7w0VCVbeK91wbHuyQGOndSjMts3g515CccP2HsWkW6evQf3jVoE/ukbP
	gxkeC8ZrC9+8p/b7UzHoMySsN8XF5f9uNcsWQuGuGa03wmNSzw2jTg+ikRftiQ82afgkVMcLIOG
	865PAg59iENRR9c24bpbMlAzoi5YEOFRL8Lc0/Uv1J5k7qFrBfXRgZ/JTGU8jrFs2idQrZYmjz8
	av0fYToPSdtMurok+l5FvLKBQ8n3HnCt5TCGVOdlavKZ4P3yFUvkCkDuSxOSgB6mB/JMep7domj
	5WOw7g5xdQTBEAat8gK7WVgf463+CsvpVr4NP8C9R6QFfWD2OdFUPKZ4=
X-Received: by 2002:a17:902:d54f:b0:2d5:c090:3810 with SMTP id
 d9443c01a7336-2dfa615a5b9mr3166565ad.2.1790563634286; Sun, 27 Sep 2026
 19:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924185316.2831077-1-hramamurthy@google.com>
In-Reply-To: <20260924185316.2831077-1-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Sun, 27 Sep 2026 19:47:01 -0700
X-Gm-Features: AclHuK-e80j_tEsr2eWKoIEd6Nv5MH1_swonyIC0fjDKChHLUEFmd8yxlyMBtRM
Message-ID: <CAEAWyHfHGhExuWf77nG7W=Bh0crzdb-LQvR0wsc7dRrtjs9yBw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/12] gve: AdminQ mode related refactors
To: netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:53=E2=80=AFAM Harshitha Ramamurthy
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
> Changes in v8:
> - Patch 6(Sashiko):
>     - call gve_queues_stop() directly in gve_queues_start() to handle XDP
>       info unregistration
>     - drop gve_queues_mem_remove() from gve_queues_start() and leave it t=
o
>       the caller; this moves a few function definitions around to avoid
>       forward declarations
>     - revert the gve_mgmnt_intr() behavior change from v7
>     - handle the TOCTOU when checking for a pending reset
>     - record all configurations in priv before sending an AQ command that
>       can result in a reset
>     - update the commit description regarding teardown-related resets
> - Patch 8(Sashiko):
>     - gate mgmt IRQ and notify block teardown on different conditions
>     - move gve_teardown_notify_blocks() from gve_reset_device() to
>       gve_teardown_device(), and tear down notify blocks as part of the
>       device reset
>     - don't set block->irq when tearing down notify blocks; instead guard
>       the disable_irq() call in gve_remove_napi() on whether the IRQ was
>       requested
> - v7: https://lore.kernel.org/netdev/20260916165533.2187434-1-hramamurthy=
@google.com/
>
> Changes in v7:
> - All changes are in patch 6(Sashiko):
>     - Return IRQ_HANDLED instead of IRQ_NONE in gve_mgmnt_intr()
>     - disable service task instead of stats report task for gve_probe() e=
rror
>     - cancel stats report in gve_free_stats_report()
>     - extract gve_teardown_control_plane_resouces() and gve_adminq_free()=
 into
>       new gve_reset_device() to ensure the device reset is triggered befo=
re
>       stopping queues
>     - don't call gve_queues_stop() in the gve_close() error path since th=
e
>       gve_reset() takes care of that.
> - v6: https://lore.kernel.org/netdev/20260909191136.3811892-1-hramamurthy=
@google.com/
>
> Changes in v6:
> - update commit message to be more consistent with code (patch 1,9 Sashik=
o)
> - call out MTU validation change (patch 1, Sashiko)
> - A few other Sashiko related fixes (error propagation in patch 2, drop d=
ouble
>   logging in patch 5, drop unintentional type conversion in patch 11)
> - v5: https://lore.kernel.org/netdev/20260903215606.31633-1-hramamurthy@g=
oogle.com/
>
> Changes in v5:
> - This series contains 12 patches since 3 patches from v4 were applied
> - Picked up Przemek Kitszel's Reviewed-by tag
> - Honor device provided default no. of Qs and max rx buffer size correctl=
y (patch 1, Sashiko)
> - drop unnecessary header files and __maybe_unused tag (patch 4, Sashiko)
> - fix workqueue disable count, destroy rings before stopping Qs, stop que=
ues in error path
>   in gve_close, preserve ordering of gve_turndown->gve_destroy_rings->gve=
_queues_stop
>   during close and reset (patch 6, Sashiko)
> - drop double logging in all paths for queue creation/destruction (patch =
11, Sashiko)
> - v4: https://lore.kernel.org/netdev/20260814021406.3044324-1-hramamurthy=
@google.com/
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
>
> Harshitha Ramamurthy (6):
>   gve: add struct gve_device_info to hold device properties
>   gve: introduce control plane operations structure
>   gve: introduce ctrl ops to set vectors and Qs
>   gve: introduce gve_adminq_get_device_properties()
>   gve: refactor gve_init_priv for reset path
>   gve: add ctrl ops for queue operations
>
> Joshua Washington (6):
>   gve: simplify reset logic
>   gve: add gve_ctrl_ops for gve initialization/teardown sequences
>   gve: split up notify block allocation and setup paths
>   gve: introduce new methods to handle IRQ doorbells
>   gve: setup and teardown management interrupts
>   gve: add link status/speed ctrl ops

There are a few high/medium issues that Sashiko has spotted for patch
6. Will fix in v9.

>
>  drivers/net/ethernet/google/gve/gve.h           |   87 +-
>  drivers/net/ethernet/google/gve/gve_adminq.c    |  376 ++++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h    |   30 +-
>  drivers/net/ethernet/google/gve/gve_ethtool.c   |    5 +-
>  drivers/net/ethernet/google/gve/gve_flow_rule.c |   15 +-
>  drivers/net/ethernet/google/gve/gve_main.c      | 1067 ++++++++++++-----=
------
>  drivers/net/ethernet/google/gve/gve_utils.c     |    4 +-
>  7 files changed, 972 insertions(+), 612 deletions(-)
>
> --
> 2.56.0.rc1.310.g51773c2048-goog
>
