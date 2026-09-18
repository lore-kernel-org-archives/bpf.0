Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F073AB48C;
	Fri, 18 Sep 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723214; cv=none; b=Zh/NfrzTTNpgPo2kvI1LA4HTe72K2htRFsbwJiwqZ6z8UVvt7BZXj+QGGvy308G22cnSgoJFJ+KIsA6rcnAzf57IPokYTgB1ZVzUwjIH/uBDOgK7jLZOM/SKDjG0I+aLOdQ7guwnGllth+v5sC5+wOEx3FcUxA9TFM3WBopx0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723214; c=relaxed/simple;
	bh=tDr7XkPAXUmUhAgolShr3Kj+oh5yuZ7vNa0c/U9YfH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nh4ekDEuCO9RXtjScnXu0ofBBNTcxhUlCrKP2l/t6AyHZJW3ESZXIzp/kUIiegZldSBcRQ1Uokd3pd+5FkKmvg1r1XiucF24mcHU6utGqiVc28PrBp2vh1myFQlEysR2MVQlEBZk1Yo63DTvMR0qHoW8AbO1NXS1RrN+0wz4fmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSS+1b+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSS+1b+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08151F00893;
	Fri, 18 Sep 2026 09:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723212;
	bh=30xzmZCW+6HrhaUbTYGuNvdh+dAtTOvqeFt7mxq9frY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZSS+1b+cDnDf88HFOj9p/K2WQbsDG052jTPK5sY5EipxYuElwpcVtfenn+XI78x6w
	 ZuFJHWYF1um614nB2nrsMiFPhfOQefihSfQfHbT36JJsB7nRc6P+Ens2E7Hr0f7bYe
	 xQUaffYT/L5kkA6XVyE0+JGYjQFAJ1Ulb2onK+PiKvdIVrTw5jkN290CHy6xhV5zje
	 5+obxfxc4Tc2YBq4RFffHzLpD4+tsZsos+6zt8+L9qQrWfaCy1THdlOxo5GervYzFB
	 j1q11VIomS2R4RPe3lvelfW8RX1BBpjiaEwm5a68mlG1bJ21GfG3mhUEu2g8OAB/FK
	 Ue/+KdKBK7M7w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 18 Sep 2026 11:19:59 +0200
Subject: [PATCH 1/2] binfmt_misc: fix OOB read in
 bpf_binprm_select_interp()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-work-binfmt_misc-fixes-v1-1-647b24bc1c46@kernel.org>
References: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>
In-Reply-To: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>
To: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4984; i=brauner@kernel.org;
 h=from:subject:message-id; bh=R6XSAxqcNhFzj5zbjdedhZcJqmgmYcg/QBbKgJYDpAc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStZXJLeRO8gMXK48LXfVOrNUKKSjdvZntVliBQLfviL
 V/7B8OojlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8XsjwV6794oojxstLCmbO
 YLvS0FmxZgIf84T55SYTs/jkGbQE0xj+2RybzVXwhGFrrPK7P9e8lGvkpTadSTOTLEtOrn7ZL/G
 CAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

From: Chris Mason <mason@kernel.org>

bpf_binprm_select_interp() checks the name its load program passes with
strnlen(name, name__sz) and then hands the same buffer to
binfmt_misc_find_interp(), which compares it with an unbounded strcmp().
The buffer can be a BPF map value that another CPU rewrites between the
two reads. If the terminating NUL is overwritten in that window, strcmp()
reads past the name__sz bytes the verifier checked. That is an
out-of-bounds read of up to 31 bytes of whatever follows the checked
name__sz bytes.

The verifier checks the name and name__sz pair with BPF_READ | BPF_WRITE,
so a writable array map value is an accepted argument.
bpf(BPF_MAP_UPDATE_ELEM) on an array map copies the new value over the
old one in place and takes no lock. The NUL that strnlen() finds can be
overwritten before strcmp() reads the buffer again:

    CPU0                                   CPU1
    bpf_binprm_select_interp()
      strnlen(name, name__sz)
        finds the NUL inside name__sz
                                           bpf(BPF_MAP_UPDATE_ELEM)
                                             array_map_update_elem()
                                               copy_map_value()
                                                 overwrites the NUL
      binfmt_misc_find_interp()
        strcmp(interp->name, name)
          reads past name__sz

strnlen() proves that a NUL lies inside name__sz only at the moment it
runs. The map update on CPU1 takes no lock, so it can store over the NUL
right after. The lookup on CPU0 then walks the live buffer again, once
per bound interpreter:

    fs/binfmt_misc.c:binfmt_misc_find_interp

        list_for_each_entry(interp, interps, list)
                if (!strcmp(interp->name, name))
                        return interp;

strcmp() stops at the first mismatch or at the end of interp->name.
bm_entry_add_interp() caps a bound name at BINFMT_MISC_INTERP_NAME_MAX
(32) bytes, so strcmp() reads at most 33 bytes of name. The smallest
name__sz the kfunc accepts is 2, which leaves up to 31 bytes read beyond
the checked extent. The handler's own load program has to pass a
writable map value, and something has to store into it while the kfunc
runs. The window between strnlen() and strcmp() is short, but with a
BPF_F_MMAPABLE array the store is a plain user space write into the
mapped value, so a loop can hit it without a single bpf() call.

Copy the name into a stack buffer of BINFMT_MISC_INTERP_NAME_MAX + 1
bytes, terminate it, and look up the copy. The memcpy() length is below
name__sz, so the copy stays inside the extent the verifier checked, and
the BPF buffer is not read again afterwards.

Return -ENOENT first for a name longer than BINFMT_MISC_INTERP_NAME_MAX.
bm_entry_add_interp() rejects a longer name, and the only other binding
site attaches the empty name. No entry can bind such a name, so that
lookup already ended in -ENOENT and no result changes.

Check the first byte of the copy and return -EINVAL if it is NUL, as the
existing "!len" test does for an empty name. Only an 'F' entry binds the
empty name and a 'B' entry cannot carry 'F', so without that check a
racing store of NUL to byte 0 would look up a name no entry binds and
end in -ENOENT rather than -EINVAL. A NUL stored further into the name
only shortens it to another name the program could have passed anyway.

binfmt_misc_find_interp() itself is left alone: entry_attach_interpreter()
calls it with a kernel string, and this kfunc now calls it with a private
copy.

Fixes: 6ec7c96bee30 ("binfmt_misc: let a 'B' entry bind its interpreters")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc_bpf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc_bpf.c b/fs/binfmt_misc_bpf.c
index 91576ff05911..ce1bc78e8511 100644
--- a/fs/binfmt_misc_bpf.c
+++ b/fs/binfmt_misc_bpf.c
@@ -176,6 +176,7 @@ __bpf_kfunc int bpf_binprm_select_interp(struct linux_binprm *bprm,
 					 const char *name, size_t name__sz)
 {
 	const struct binfmt_misc_interp *interp;
+	char buf[BINFMT_MISC_INTERP_NAME_MAX + 1];
 	size_t len;
 	char *path;
 
@@ -184,8 +185,20 @@ __bpf_kfunc int bpf_binprm_select_interp(struct linux_binprm *bprm,
 	len = strnlen(name, name__sz);
 	if (len == name__sz || !len)
 		return -EINVAL;
+	/* No entry binds a longer name, so it cannot be found. */
+	if (len > BINFMT_MISC_INTERP_NAME_MAX)
+		return -ENOENT;
+
+	/*
+	 * The program may pass memory that is written to while this runs,
+	 * so look the name up in a private copy and check that instead.
+	 */
+	memcpy(buf, name, len);
+	buf[len] = '\0';
+	if (!buf[0])
+		return -EINVAL;
 
-	interp = binfmt_misc_find_interp(bprm->bpf_interps, name);
+	interp = binfmt_misc_find_interp(bprm->bpf_interps, buf);
 	if (!interp)
 		return -ENOENT;
 

-- 
2.53.0

