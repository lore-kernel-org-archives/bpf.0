Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA340B0FB
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884232; cv=pass; b=LdIhMDsaC3MUK0OJhyoFI7hfId6Sa4N+qjbSYu3N8nCjV9+TW7ibeY+Z6Lj9WSsIxumyH36K+QJCwS8bJgvmhtYxPIzXIfrhafXk9VHgVoVWWKHFQkmUVMtYKqgrCMcfaMDztUGzuW2xJZHhBj9DnmG1yCCS13xwuxBpTtIBt2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884232; c=relaxed/simple;
	bh=pCcucelvTgN2Td/MTOplDbVEOwJx9b77rtf4GdATMWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDyCfdz4J78F45ahb5ccFQy/bol11iK5M1NFvAJ70QHAXGi1QvgqdAnIgFQN+dVOSWz5Ae4mkKoZ3VGRnTgZdXBMNrMnZ2cE5+Gup6dvbUSWGI+wPfJKbCZI3len8L6XG8ZBrv+h35y4aIDR7lnLM1a7QjXslPIv4/cN/TeIQrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBI8XRMq; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBI8XRMq"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so383374b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 15:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785884229; cv=none;
        d=google.com; s=arc-20260327;
        b=KyfEK3l53HsdyH0y6/aK1uo56RkCg48YJrltvWSQaoPTT7k9Od1sTkgtTLjj4YllWD
         m7V/lzKk8Xsdp3JP1l3/rBK9fPZjSHxjtrblSyKYIf+p0qLafoWW0GdtNDLGoeLz4rxY
         LA0jZKdeoiedX4LBTWUtRnrKnSKY1u7NI+DhaPiOgK+WX+feSimRjMZ/Egxv0miMuvcZ
         XlEITR8MVTyqPfx2c8YS3lfMqyDY2FT41pOngzUX8dCegRJvha3AXt4/0JNoe0ybUeI3
         spXBkejaWe+nmJ5KWTN+7psQUB72gwQbED9wOTiCfN+Ig3ZrILbX7TZlFM6ZJVrEtOeX
         9j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b2nm2ZM8VmIzL1xZkDU98gcAinDV1MGDu/mMU+G0lBc=;
        fh=Dmzh56mZ+EcQ1ayYX0EQaMLiD5QrBuMOtm0XOT+dxMg=;
        b=gby6g3fsonucCAU1s492JWWT8ATzbvt/pYF6r1aClWwKK9oZZHJ1PW5ukmdwLUqYAk
         xOE7nO/aYrg0WoTmsZYEHba4g+Br/AucnAK1jdqvvv2KO62PWG1WeonGyY9Ni9UST+P1
         SyrKlNgzt0RX29K2N0yXhqnP60lBmEMr+VwT9cn6ZMy5y9Gm435U3GG2XgvKzQ1vL25u
         hO+t9YcS901ssOZKt9nKtpbckmWVv6iSH4AwWoVa3yBTH0jo4r0znj7dQ5Fh/lKsl0mP
         ve7oMisfyu2rDWETxVxSNwi3fXrjVX60ouvk4rS2XoWru2NEai52qWi5D58waYDRgWvJ
         R8ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785884229; x=1786489029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b2nm2ZM8VmIzL1xZkDU98gcAinDV1MGDu/mMU+G0lBc=;
        b=kBI8XRMqy60UFBrn0YcrK4Tfqetm2Ms9cTSMyTacl1Un9jRqHyahk2ZAwkVmvOa47x
         +IiZFe4e5bNnYfAV2jccKx8CGl4/1e2WKENC11iGgytOxXH8SoAoyf1PxYW8e4WMom7i
         /yUYyOcUFpAHTFzI/NOKu3k8tZrPm+Mmr7oo1DVKeQ4sSrVEcTLQm2mv6Ai3B3i4TAnp
         PEMAEt7bEM2fYXgACxfNDTfQiBe6AXHkzvLlf7RL7BPGHY51eSHjLpyOuZoiwdAiHgUD
         NpUKYiBP55s99RAr/VycxTrAzJiWJVYFJ4OWlU6Hulg43fTbnle5bK38P3ji9T+bzvAy
         kOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785884229; x=1786489029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2nm2ZM8VmIzL1xZkDU98gcAinDV1MGDu/mMU+G0lBc=;
        b=lTWW8Vmx63hRObaEqont2ysjueuVR3GiYBBpkukxBgAWI9BILYiazTEPZ6tEuVr9B1
         OjzUwwZB9B4G0y5fuDL7ouNT8vHCDL0ITH9C3eDz3epEDvLNn2w1LUjKvZaPg03qdXBm
         6IoLF1Fi3qJJVjjCURQr6/00Mzxr6nJHLwy0FQuVwdBlJeUDMB33Gbf4x4X7KbqdGRmt
         AhmtI1mHT0J4JLiBPqGApr2k++mOVO85x+hdl07ryEFovzxFMx/6f/cPjKH7Wxi8Al9M
         DWQFlsprsQQ5eNQdqD2evPdpSvuy56tTargJcox5YyW6KHPzzbQptigvpLHHS02hD+NC
         utiw==
X-Gm-Message-State: AOJu0YyfT8Vk7Txq+iHCqMe0IXCJaJd6k+BmiCIAaYVMLUf+aGHiAo4v
	b14Y1T49xQK83CKu8jimPmMB2GwfKUAPomu7hDSHHOxN+vvzlhXAOf1/dA75pbiGrTPXNRucccT
	YH7Ju8Lc2jjkZlocuPGbAxIGpbysLtxM=
X-Gm-Gg: AR+sD131P/+oPcs+UDzU+CqcnL4rRa6yYSJMca3kAP5lM9Dj3Mpo9wB5eCWx/1HH5za
	pKpuyr7Zd2/AFr/NiybWltZUMvYKjq8gDSP8UvLzPTQh3TpOb15CobtHmV+yskN5sF61qSFDBiG
	78iPh5MvpAV0FP2C0ZGTeA8FBfktAipsJci0vmuo+eJnnAdPKwaRx1OOjMlANdImdjbopyYDKGd
	DqAVDHhJzvkqRzV1Z2S1MnDamPiibiG7zf53a2BtypiWor6iUeUY8TwiL1G6155/UraLgesovgz
	Dsy00CFeC5wBoRdtaZE+VSG5NGSaz7mnlaKmp75U1ZC4/Qpg+qZFf7+Tlae2oV029MykH+32x7Q
	F0oYPfCOcLP981JFzYNpSKUzwAc7opcTr7P61Wp2wzQ==
X-Received: by 2002:a05:6a00:2c9:b0:848:5ed6:9d27 with SMTP id
 d2e1a72fcca58-84f2e12c9f4mr2197616b3a.36.1785884229213; Tue, 04 Aug 2026
 15:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728133058.2858367-1-pulehui@huaweicloud.com>
In-Reply-To: <20260728133058.2858367-1-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Aug 2026 15:56:55 -0700
X-Gm-Features: AUfX_my3faydhSOLI9eHlInGLPrliadjgOmBRJ67MOi7ofJvgqCLsT6__WJiFUc
Message-ID: <CAEf4BzbbWsETCtOdsi-sCo2TVFFGi97Z-x1zcNgTANoBkop1rg@mail.gmail.com>
Subject: Re: [PATCH bpf v4] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:26=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> Syzkaller reported a storage null-ptr-deref issue after replacing prog.
> This occurs in the following scenario:
> 1. prog A, an empty prog, is attached to a cgrp.
> 2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
>    bpf_get_local_storage helper.
> 3. link_update is called to replace prog A with prog B.
>
> The reason is that __cgroup_bpf_replace fails to alloc and assign the
> required cgrp storage for the incoming replacement prog. Consequently,
> the new prog inherits an uninit storage, leading to null-ptr-deref panic
> when kick the new prog.
>
> Fix this by properly allocating the storage and comparing the old and
> new storage pointers. If the storage changed, fallback to
> update_effective_progs which performs a RCU-safe update of the entire
> array. If the storage remains unchanged, we can safely retain the
> fast-path in-place update.
>
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active b=
pf_cgroup_link")
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
> v4:
> - Extract the fix for __cgroup_bpf_attach() into a standalone patch [0].
> - Add Reviewed-by tag by Amery.
> - Separate from patchset [1]. (Andrii)
>
> Link: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huawei=
cloud.com [0]
> Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@hu=
aweicloud.com [1]
>
> v3: https://lore.kernel.org/bpf/20260720134547.1289964-5-pulehui@huaweicl=
oud.com
> - Include the storage and flags rollbacks to patch4 for sake of code rigo=
r,
>   as it's hard to make update_effective_progs fail in __cgroup_bpf_attach=
.
>
> v2: https://lore.kernel.org/bpf/20260717073343.958862-1-pulehui@huaweiclo=
ud.com
> - Fix invalid access for in-place update when storage changed. (Sashiko)
>
> v1: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweiclo=
ud.com
>
>  kernel/bpf/cgroup.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c..e2fa0ebeed83 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1032,11 +1032,17 @@ static int __cgroup_bpf_replace(struct cgroup *cg=
rp,
>                                 struct bpf_cgroup_link *link,
>                                 struct bpf_prog *new_prog)
>  {
> +       struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYP=
E] =3D {};
> +       struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYP=
E] =3D {};
> +       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] =
=3D {};
> +       enum bpf_cgroup_storage_type stype;
>         enum cgroup_bpf_attach_type atype;
> +       bool storage_changed =3D false;
>         struct bpf_prog *old_prog;
>         struct bpf_prog_list *pl;
>         struct hlist_head *progs;
>         bool found =3D false;
> +       int err;
>
>         atype =3D bpf_cgroup_atype_find(link->link.attach_type, new_prog-=
>aux->attach_btf_id);
>         if (atype < 0)
> @@ -1056,10 +1062,39 @@ static int __cgroup_bpf_replace(struct cgroup *cg=
rp,
>         if (!found)
>                 return -ENOENT;
>
> +       if (bpf_cgroup_storages_alloc(storage, new_storage, link->link.at=
tach_type,
> +                                     new_prog, cgrp))
> +               return -ENOMEM;
> +
> +       for_each_cgroup_storage_type(stype) {
> +               if (storage[stype] !=3D pl->storage[stype]) {
> +                       storage_changed =3D true;
> +                       break;
> +               }
> +       }
> +
>         cgrp->bpf.revisions[atype] +=3D 1;
>         old_prog =3D xchg(&link->link.prog, new_prog);
> -       replace_effective_prog(cgrp, atype, pl);
> +
> +       if (!storage_changed) {
> +               replace_effective_prog(cgrp, atype, pl);
> +               bpf_prog_put(old_prog);
> +               return 0;
> +       }
> +
> +       bpf_cgroup_storages_assign(old_storage, pl->storage);
> +       bpf_cgroup_storages_assign(pl->storage, storage);
> +       err =3D update_effective_progs(cgrp, atype);
> +       if (err) {
> +               xchg(&link->link.prog, old_prog);

I'm not a fan of having this transient link.prog transition from old
to new and back to old prog if something goes wrong.

Given this is syzbot (only) reported issue, how about we just check
that cgroup storage (legacy one at that) of old and new program is
compatible, and if not, just reject link update? that would be less
risky change

pw-bot: cr


> +               bpf_cgroup_storages_assign(pl->storage, old_storage);
> +               bpf_cgroup_storages_free(new_storage);
> +               cgrp->bpf.revisions[atype] -=3D 1;
> +               return err;
> +       }
> +
>         bpf_prog_put(old_prog);
> +       bpf_cgroup_storages_link(new_storage, cgrp, link->link.attach_typ=
e);
>         return 0;
>  }
>
> --
> 2.34.1
>
