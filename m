Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8393B893C
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881682; cv=none; b=gleOmC8H1AmOi0Tpd4br80uhOyy4/E6104qPCccdKrcu2ky63fpCm+bTtMZrNZWe3vqcNIaJEJwSs77exBLzgSdot2PdffgptDlDI5xvHeccvYaK8UCxqbUPMqUtK/XdqoGAD9ywa6Q43YdIUGEgU/J5NIGi53aSCOIDsE/DnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881682; c=relaxed/simple;
	bh=V9N6yu7C7hh3ql1S7Ms9hAN8X7NGoHzphW6jDuEYINk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ra1MPJslPU7Nn42VDNKabrKvlfYNSMVp1YwazUSjSRKAurY7waoDM/sb7WWuCJxLna+GD/j5T7kDOxFTAGZiY2iRFbEBxJ+UMdAefxpaNQoJR1MhqQFMMDApdyEvitW+H0XYuEnbJAmX9oYBvIZq+MEs/10Y6A0wDulrDYmlCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=f0IRafLy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="f0IRafLy"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533930955a4so25907721cf.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791881679; x=1792486479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uSQZji3sqvNi3i8gGe7j8+xn6kdlHXblMrW24TcijKA=;
        b=f0IRafLydVC9U56XtJzUkndIi/V6TsE1YH9wLoOnEIdsHrW/vU1orfn6pOEapqDqmG
         2vK3iDqDnoYvRTtb97dLRxJdPxm68SugvoC52y8Lkcr0VTFD+25+pSuEyebL9OZPvVr7
         K5IC4b+RmaohT0I8FMN67Xox8SRQmEVfNwzMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881679; x=1792486479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uSQZji3sqvNi3i8gGe7j8+xn6kdlHXblMrW24TcijKA=;
        b=eophFOEqGHLj8JnUUvpVP1TbV1Zfc4cpYKouX07XXd0QAq+2r4viVa1scu+XckCCSr
         yM6Hhjm+wuvOTqG6JwSW0lUyA1t79w1wJ9ICgbd1vATcAMA49Fw9DCc5U2+QnVlq+n4C
         PYRUoQkhDRCuMV/ETLc5iTD/lARC/G5BLVcSdrcU5vnzY3OJFJ18ZBLdbTcEGuUKNOKp
         0l8CNhXB5wJ+yyUWnyuV0Kl8HH1fanujVAY0oymIZkDvL7KbM8H0438zbFXnB+XHiuBy
         8DoPB8qTfZPOgxMrXtLXTMcK5qAaffYNM/VIieAgxEIqI7W5xhGk3/LHl6PJ5YSJ9LfH
         Ldog==
X-Forwarded-Encrypted: i=1; AKwUvByd9nI33kme5inldWVIUDZiaFYnLfCF6HhgwQDl6RLjElVrS1XV+5OgI7uIVWw7AXRhZ3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPhlVaipG5oQcwSP+X8yslCRoENiJxfyXKcdYhybRLWQUMgw4P
	lxFj88A1kdC5fesWKmFkX9SJ5ZD/Hoa3JXkW511CYaSZlVxN4CxnmlbJMIRALDI7mQ==
X-Gm-Gg: AYBFou00cPlgg8WvkP5RtfR4q64V5YaXTMuTrrxC4qiWZUOhHp6iPaK3D/MEguhQxCf
	IqlJdTy9XC0VPhqIBefyjplAWfWgwh/Y9g0PhOm2ocHs7VDd+q1bynb0AkTGOX2t0FVZ82fUm18
	6nEmjN5liJgVnCi9rO99f5YmnPZ47KJ37H79ghanE+B6Mmtz1lBJ1PuvpnUKFls0SFoyxAYSke6
	t21LIZtDVhD9ovqbqxo5W/kTjzWbfp//c1unsvdcD3DFlnQHkhQt+y5/IiRXkzO2EjhaGMcd+2b
	/fqjawy2RPz8WpyKR5v/6UmYUzaYxnrKtAAAMDy5gdEv2dxRRpUjB+RcHIkw0HwPrjW7uKHx/dB
	IWib13MWhgfJ+BliLIVGiQvgqyocUQDKL2oFB9MGVVlE+U72UHCcUtrz0V8mCjVbGJallK7yK7S
	22Je/umNAWM7ngUM1etwe6sIolefIU6X9yBVTN3W14VV/yJZu5eLJiyz8Qy+LAm7+wZ9kaHvmxF
	Z6kKYrpon3+Yu9uXgf9kVSxsqCs/eRhbTnAp7AU+J082A==
X-Received: by 2002:a05:622b:c1:10b0:535:a5fb:644d with SMTP id d75a77b69052e-535a5fb6996mr128422851cf.71.1791881678745;
        Tue, 13 Oct 2026 01:54:38 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b731a6csm97763401cf.11.2026.10.13.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:54:36 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Paul Moses <p@1g4.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Davide Caratti <dcaratti@redhat.com>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next v3 0/5] net/sched: reject oversized action dumps and cap unbounded entry lists
Date: Tue, 13 Oct 2026 04:54:26 -0400
Message-Id: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An action dump is carried inside nested netlink attributes whose lengths
are u16. When a single action's dump does not fit, a plain nla_nest_end()
writes a wrapped length and the kernel hands userspace a corrupt reply; on
the classifier path the -EMSGSIZE this produces is mistaken for socket
buffer exhaustion and retried in a loop that can never succeed.

Patch 1 makes every nest an action dump can be carried in fail cleanly
(-EMSGSIZE) instead of wrapping, bounds the tfilter_notify_prep() retry,
and stops a notification that cannot be built from vetoing a filter or
action delete. Patch 2 stops an action add whose actions were already
committed from being reported as a failure when the notification cannot
be built. Patch 3 caps the number of gate scheduling entries at 1024,
rejected with -E2BIG and an extack message. Patch 4 caps the number of
taprio schedule entries at 1024 in the same way. Patch 5 makes the action
dump report an action that cannot be serialized into one dump skb as
-EMSGSIZE instead of returning success and silently dropping the rest of
the list.

Patches 3 and 4 each bound an unbounded userspace-supplied entry list that
a reviewer reading the gate cap would ask about next: the qdisc-side
sibling and the SJA1105 schedule-table producer. Patch 5 closes the
silent-truncation that the cap admits but cannot reach. They are folded
into this posting so the family is fixed in one patchset rather than a
stream of follow-ups; each stays a separate commit, so any one can drop
out without touching the others.

A pre-existing filter reference-count leak in cls_flower, found alongside
this work, is being sent to net as its own fix with a Fixes: tag; it is not
part of this series.

This patchset is a retarget from net to net-next of the previous posting:
https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/
The wrapped-nla_len corruption this series addresses is not a regression of
commit cfa165cbfbed ("net/sched: act_gate: budget the per-entry list in
get_fill_size"): the enclosing action and filter nests antedate it and a
plain nla_nest_end() has always written the wrapped length at U16_MAX.

This is hardening, not a regression fix, so it targets net-next.

v1 -> v2:
  - Retarget to net-next and drop Fixes:/Cc: stable, as it is hardening
    rather than a regression.
  - Add the entry-count cap into the series as patch 2/2 (now 3/5), as the
    parent commit promised for net-next.  The cap value is 1024, grounded in the
    SJA1105 schedule-table capacity and the 16-bit netlink TLV boundary.
  - Patch 1: add seven additional action-capable classifier
    TCA_OPTIONS closes and correct the Conditions Kconfig name.
  - Sashiko review of that posting:
    https://sashiko.dev/#/patchset/QDISC-H19Z.v1.20261001053234%40mojatatu.com

v2 -> v3:
  - Patch 1: the action-delete path no longer lets an unbuildable
    RTM_DELACTION notification veto the delete.  tca_get_fill() and
    tcf_del_notify_msg() pass -EMSGSIZE up, and tcf_del_notify() drops the
    notification and proceeds with the delete.
  - Patch 1: the filter-delete path drops an unbuildable notification and
    proceeds with the delete; its "Filter deleted" extack is set only after
    ->delete() has returned 0.
  - Patch 1: the retry bound is documented as part of the same change as
    the checked closes, and -EMSGSIZE is noted as the general
    tcf_fill_node() outcome rather than a u16 overflow only.
  - Patch 2: the action-add path no longer reports a failure after the
    actions are committed.  tcf_action_add() drops a notification that
    cannot be built and returns success, so an RTM_NEWACTION that created
    its actions is no longer reported back as -EINVAL (mirrors
    tc_new_tfilter(), which never fails a filter create on a notify
    failure).
  - Sashiko reviews of v2:
    https://sashiko.dev/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
    https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
  - Fold the qdisc-side sibling into the series as patch 4/5: cap the
    taprio schedule entry list at 1024 (TAPRIO_ENTRIES_MAX) in
    parse_sched_list(), rejected with -E2BIG and an extack.  Same
    unbounded-entry-list family as the gate cap, grounded in the SJA1105
    schedule-table capacity, and a separate commit.
  - Fold the dump path into the series as patch 5/5: tcf_dump_walker() and
    tc_dump_action() now report an action that cannot be serialized into a
    dump skb as -EMSGSIZE (with an extack) instead of returning success and
    quietly dropping the rest of the list.  Reported and suggested by Paul
    Moses.

Jamal Hadi Salim (5):
  net/sched: act_gate: reject oversized dumps instead of wrapping them
  net/sched: act_api: keep an add that created its actions from failing
  net/sched: act_gate: cap the number of scheduling entries
  net/sched: sch_taprio: cap the number of schedule entries
  net/sched: act_api: report an oversized action dump instead of
    silently truncating it

 net/sched/act_api.c      | 87 ++++++++++++++++++++++++++++------------
 net/sched/act_gate.c     | 18 ++++++++-
 net/sched/cls_api.c      | 38 +++++++++++++-----
 net/sched/cls_basic.c    |  3 +-
 net/sched/cls_bpf.c      |  3 +-
 net/sched/cls_cgroup.c   |  3 +-
 net/sched/cls_flow.c     |  3 +-
 net/sched/cls_flower.c   |  6 ++-
 net/sched/cls_fw.c       |  3 +-
 net/sched/cls_matchall.c |  3 +-
 net/sched/cls_route.c    |  3 +-
 net/sched/cls_u32.c      |  3 +-
 net/sched/sch_taprio.c   | 14 +++++++
 13 files changed, 141 insertions(+), 46 deletions(-)

-- 
2.43.0

